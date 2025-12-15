import 'package:get/get.dart';
import 'app_routes.dart';
import '../../presentation/screens/main_navigation_screen.dart';
import '../../presentation/screens/result_detail_screen.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.main,
      page: () => const MainNavigationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.resultDetail,
      page: () => const ResultDetailScreen(),
      transition: Transition.cupertino,
    ),
  ];
}