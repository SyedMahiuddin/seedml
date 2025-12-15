import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../../core/constants/seed_data.dart';

class ClassificationResult {
  final String label;
  final double confidence;

  const ClassificationResult({
    required this.label,
    required this.confidence,
  });
}

class ClassifierService extends GetxService {
  Interpreter? _interpreter;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/seed_data.tflite');
      _isLoaded = true;
    } catch (e) {
      _isLoaded = false;
      rethrow;
    }
  }

  Future<ClassificationResult?> classify(File imageFile) async {
    if (_interpreter == null) return null;

    try {
      final imageBytes = await imageFile.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) return null;

      final inputShape = _interpreter!.getInputTensor(0).shape;
      final inputSize = inputShape[1];

      final resizedImage = img.copyResize(
        originalImage,
        width: inputSize,
        height: inputSize,
      );

      final input = _prepareInput(resizedImage, inputSize);
      final inputReshaped = input.reshape([1, inputSize, inputSize, 3]);

      final outputShape = _interpreter!.getOutputTensor(0).shape;
      final output = List.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);

      _interpreter!.run(inputReshaped, output);

      final results = output[0] as List;
      final scores = results.map((e) => (e as num).toDouble()).toList();
      final maxIndex = scores.indexOf(scores.reduce((a, b) => a > b ? a : b));
      final confidence = scores[maxIndex];

      final label = maxIndex < SeedData.labels.length
          ? SeedData.labels[maxIndex]
          : 'Unknown';

      return ClassificationResult(label: label, confidence: confidence);
    } catch (e) {
      rethrow;
    }
  }

  Float32List _prepareInput(img.Image image, int inputSize) {
    final convertedBytes = Float32List(inputSize * inputSize * 3);
    var pixelIndex = 0;

    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        final pixel = image.getPixel(j, i);
        convertedBytes[pixelIndex++] = pixel.r.toDouble() / 255.0;
        convertedBytes[pixelIndex++] = pixel.g.toDouble() / 255.0;
        convertedBytes[pixelIndex++] = pixel.b.toDouble() / 255.0;
      }
    }
    return convertedBytes;
  }

  void dispose() {
    _interpreter?.close();
  }
}