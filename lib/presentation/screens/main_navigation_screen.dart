import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/theme_helper.dart';
import '../controllers/navigation_controller.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'statistics_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (controller) => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex,
          children: const [
            HomeScreen(),
            HistoryScreen(),
            StatisticsScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(context, controller),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, NavigationController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeHelper.cardColor(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                index: 0,
                icon: Icons.home_rounded,
                label: 'Home',
                isSelected: controller.currentIndex == 0,
                onTap: () => controller.changePage(0),
              ),
              _NavItem(
                index: 1,
                icon: Icons.history_rounded,
                label: 'History',
                isSelected: controller.currentIndex == 1,
                onTap: () => controller.changePage(1),
              ),
              _NavItem(
                index: 2,
                icon: Icons.analytics_rounded,
                label: 'Stats',
                isSelected: controller.currentIndex == 2,
                onTap: () => controller.changePage(2),
              ),
              _NavItem(
                index: 3,
                icon: Icons.settings_rounded,
                label: 'Settings',
                isSelected: controller.currentIndex == 3,
                onTap: () => controller.changePage(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = ThemeHelper.textSecondaryColor(context);
    final color = isSelected ? primaryColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}