import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/app.dart';
import 'data/services/storage_service.dart';
import 'data/services/classifier_service.dart';
import 'presentation/controllers/theme_controller.dart';
import 'presentation/controllers/navigation_controller.dart';
import 'presentation/controllers/history_controller.dart';
import 'presentation/controllers/classifier_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await initServices();

  runApp(const SeedAIApp());
}

Future<void> initServices() async {
  Get.put(StorageService(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  Get.put(NavigationController(), permanent: true);
  Get.put(HistoryController(), permanent: true);
  Get.put(ClassifierService(), permanent: true);
  Get.put(ClassifierController(), permanent: true);
}