import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/seed_data.dart';
import '../../core/theme/theme_helper.dart';
import '../../core/utils/helpers.dart';
import '../controllers/history_controller.dart';
import '../widgets/common/empty_state.dart';
import '../widgets/common/icon_box.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
      ),
      body: Obx(() {
        if (controller.totalScans == 0) {
          return const EmptyState(
            icon: Icons.analytics_outlined,
            title: 'No statistics yet',
            subtitle: 'Start scanning seeds to see statistics',
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatCards(context, controller),
              const SizedBox(height: 24),
              _buildDistribution(context, controller),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCards(BuildContext context, HistoryController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Total Scans',
                value: controller.totalScans.toString(),
                icon: Icons.document_scanner,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Favorites',
                value: controller.favoritesCount.toString(),
                icon: Icons.favorite,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Types Found',
                value: controller.typesCount.toString(),
                icon: Icons.category,
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Avg Confidence',
                value: Helpers.formatConfidenceShort(controller.averageConfidence),
                icon: Icons.speed,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDistribution(BuildContext context, HistoryController controller) {
    final stats = controller.statistics;
    final total = controller.totalScans;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seeds Distribution',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ThemeHelper.textPrimaryColor(context),
          ),
        ),
        const SizedBox(height: 16),
        ...stats.entries.map((entry) {
          final info = SeedData.getInfo(entry.key);
          final percentage = entry.value / total;
          final color = info?.color ?? Colors.green;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ThemeHelper.cardColor(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconBox(icon: Icons.grass, color: color, size: 36, iconSize: 18),
                        const SizedBox(width: 12),
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ThemeHelper.textPrimaryColor(context),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${entry.value} (${(percentage * 100).toStringAsFixed(1)}%)',
                      style: TextStyle(
                        color: ThemeHelper.textSecondaryColor(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation(color),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeHelper.cardColor(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBox(icon: icon, color: color),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ThemeHelper.textPrimaryColor(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: ThemeHelper.textSecondaryColor(context),
            ),
          ),
        ],
      ),
    );
  }
}