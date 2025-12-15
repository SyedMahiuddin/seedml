import 'dart:io';
import 'package:get/get.dart';
import '../../data/models/scan_result.dart';
import '../../data/services/storage_service.dart';

class HistoryController extends GetxController {
  late final StorageService _storage;

  final _history = <ScanResult>[].obs;
  final searchQuery = ''.obs;
  final selectedFilter = 'All'.obs;

  List<ScanResult> get history => _history;

  RxList<String> get filters => ['All', 'Favorites', 'Recent', 'High Confidence'].obs;

  List<ScanResult> get filteredHistory {
    var filtered = _history.toList();

    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((r) => r.label.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    switch (selectedFilter.value) {
      case 'Favorites':
        filtered = filtered.where((r) => r.isFavorite).toList();
        break;
      case 'Recent':
        filtered.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        filtered = filtered.take(10).toList();
        break;
      case 'High Confidence':
        filtered = filtered.where((r) => r.confidence >= 0.8).toList();
        break;
    }

    return filtered;
  }

  int get totalScans => _history.length;
  int get favoritesCount => _history.where((r) => r.isFavorite).length;
  int get typesCount => _history.map((r) => r.label).toSet().length;

  double get averageConfidence {
    if (_history.isEmpty) return 0;
    return _history.fold<double>(0, (sum, r) => sum + r.confidence) / _history.length;
  }

  Map<String, int> get statistics {
    final stats = <String, int>{};
    for (var result in _history) {
      stats[result.label] = (stats[result.label] ?? 0) + 1;
    }
    return stats;
  }

  @override
  void onInit() {
    super.onInit();
    _storage = Get.find<StorageService>();
    _loadHistory();
  }

  void _loadHistory() {
    _history.value = _storage.getHistory();
  }

  void _saveHistory() {
    _storage.saveHistory(_history);
  }

  void addResult(ScanResult result) {
    _history.insert(0, result);
    _saveHistory();
  }

  void toggleFavorite(String id) {
    final index = _history.indexWhere((r) => r.id == id);
    if (index != -1) {
      _history[index] = _history[index].copyWith(
        isFavorite: !_history[index].isFavorite,
      );
      _saveHistory();
    }
  }

  void deleteResult(String id) {
    final result = _history.firstWhereOrNull((r) => r.id == id);
    if (result != null) {
      try {
        File(result.imagePath).deleteSync();
      } catch (_) {}
      _history.removeWhere((r) => r.id == id);
      _saveHistory();
    }
  }

  void clearHistory() {
    for (var result in _history) {
      try {
        File(result.imagePath).deleteSync();
      } catch (_) {}
    }
    _history.clear();
    _saveHistory();
  }

  ScanResult? getResultById(String id) {
    return _history.firstWhereOrNull((r) => r.id == id);
  }
}