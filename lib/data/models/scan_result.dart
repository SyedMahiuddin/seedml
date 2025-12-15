class ScanResult {
  final String id;
  final String label;
  final double confidence;
  final String imagePath;
  final DateTime timestamp;
  final bool isFavorite;

  const ScanResult({
    required this.id,
    required this.label,
    required this.confidence,
    required this.imagePath,
    required this.timestamp,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'confidence': confidence,
    'imagePath': imagePath,
    'timestamp': timestamp.toIso8601String(),
    'isFavorite': isFavorite,
  };

  factory ScanResult.fromJson(Map<String, dynamic> json) => ScanResult(
    id: json['id'],
    label: json['label'],
    confidence: json['confidence'],
    imagePath: json['imagePath'],
    timestamp: DateTime.parse(json['timestamp']),
    isFavorite: json['isFavorite'] ?? false,
  );

  ScanResult copyWith({
    String? id,
    String? label,
    double? confidence,
    String? imagePath,
    DateTime? timestamp,
    bool? isFavorite,
  }) =>
      ScanResult(
        id: id ?? this.id,
        label: label ?? this.label,
        confidence: confidence ?? this.confidence,
        imagePath: imagePath ?? this.imagePath,
        timestamp: timestamp ?? this.timestamp,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}