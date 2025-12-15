import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../app/routes/app_routes.dart';
import '../../data/models/scan_result.dart';
import '../../data/services/classifier_service.dart';
import 'history_controller.dart';

class ClassifierController extends GetxController {
  late final ClassifierService _classifierService;
  final _picker = ImagePicker();
  final _uuid = const Uuid();

  final isModelLoaded = false.obs;
  final isProcessing = false.obs;
  final currentImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    _classifierService = Get.find<ClassifierService>();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      await _classifierService.loadModel();
      isModelLoaded.value = true;
    } catch (e) {
      _showError('Failed to load AI model');
    }
  }

  Future<void> pickAndClassify(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile == null) return;

    isProcessing.value = true;
    currentImage.value = File(pickedFile.path);

    try {
      final savedPath = await _saveImage(File(pickedFile.path));
      await _classifyImage(File(pickedFile.path), savedPath);
    } catch (e) {
      isProcessing.value = false;
      _showError('Classification failed');
    }
  }

  Future<String> _saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'seed_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await image.copy('${directory.path}/$fileName');
    return savedFile.path;
  }

  Future<void> _classifyImage(File image, String savedPath) async {
    final classificationResult = await _classifierService.classify(image);

    if (classificationResult == null) {
      isProcessing.value = false;
      _showError('Could not classify image');
      return;
    }

    final result = ScanResult(
      id: _uuid.v4(),
      label: classificationResult.label,
      confidence: classificationResult.confidence,
      imagePath: savedPath,
      timestamp: DateTime.now(),
    );

    Get.find<HistoryController>().addResult(result);
    isProcessing.value = false;

    Get.toNamed(AppRoutes.resultDetail, arguments: result);
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}