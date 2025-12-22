import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Wait for 4 seconds
    await Future.delayed(const Duration(seconds: 5));

    // Navigate to Home and remove Splash from history stack
    Get.offNamed(AppRoutes.main);
  }
}