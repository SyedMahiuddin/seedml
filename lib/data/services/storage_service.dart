import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/scan_result.dart';

class StorageService extends GetxService {
  final _storage = GetStorage();

  static const _historyKey = 'scan_history';
  static const _themeKey = 'is_dark_mode';

  List<ScanResult> getHistory() {
    final data = _storage.read<List>(_historyKey);
    if (data == null) return [];
    return data
        .map((e) => ScanResult.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveHistory(List<ScanResult> history) async {
    await _storage.write(_historyKey, history.map((e) => e.toJson()).toList());
  }

  bool getIsDarkMode() => _storage.read(_themeKey) ?? false;

  Future<void> saveIsDarkMode(bool value) async {
    await _storage.write(_themeKey, value);
  }
}