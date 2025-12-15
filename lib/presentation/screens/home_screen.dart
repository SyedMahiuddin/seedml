import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/classifier_controller.dart';
import '../controllers/history_controller.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/common/empty_state.dart';
import '../widgets/home/scan_card.dart';
import '../widgets/home/seed_chip_list.dart';

import '../widgets/home/recent_scan_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ScanCard(),
                  const SizedBox(height: 24),
                  const SeedChipList(),
                  const SizedBox(height: 24),
                  _buildRecentScansSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    final classifier = Get.find<ClassifierController>();

    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.eco, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('SeedAI'),
          ],
        ),
        centerTitle: true,
      ),
      actions: [
        Obx(() => _StatusBadge(isReady: classifier.isModelLoaded.value)),
      ],
    );
  }

  Widget _buildRecentScansSection() {
    final history = Get.find<HistoryController>();
    final navController = Get.find<NavigationController>();

    return Obx(() {
      if (history.history.isEmpty) {
        return const EmptyState(
          icon: Icons.eco_outlined,
          title: 'No scans yet',
          subtitle: 'Take a photo or select from gallery to identify seeds',
        );
      }

      final recentScans = history.history.take(3).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Scans',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),
              TextButton(
                onPressed: () => navController.changePage(1),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...recentScans.map((result) => RecentScanTile(result: result)),
        ],
      );
    });
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isReady;

  const _StatusBadge({required this.isReady});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isReady ? Colors.green : Colors.orange).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isReady ? Colors.green : Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isReady ? 'Ready' : 'Loading',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isReady ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}