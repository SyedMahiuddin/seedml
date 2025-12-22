import 'package:get/get.dart';
import 'app_routes.dart';
import '../../presentation/screens/splash_screen.dart'; // Import this
import '../../presentation/screens/main_navigation_screen.dart';
import '../../presentation/screens/result_detail_screen.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainNavigationScreen(),
      transition: Transition.fadeIn, // Smooth transition from splash
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.resultDetail,
      page: () => const ResultDetailScreen(),
      transition: Transition.cupertino,
    ),
  ];
}