import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/theme_helper.dart';
import '../controllers/history_controller.dart';
import '../widgets/common/empty_state.dart';
import '../widgets/history/history_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan History',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        actions: [
          Obx(() => controller.history.isNotEmpty
              ? IconButton(
            icon: Icon(
              Icons.delete_sweep_rounded,
              color: ThemeHelper.textPrimaryColor(context),
            ),
            onPressed: () => _showClearDialog(context, controller),
          )
              : const SizedBox()),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(context, controller),
          Expanded(child: _buildHistoryList(context, controller)),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context, HistoryController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ThemeHelper.cardColor(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              onChanged: (value) => controller.setSearchQuery(value),
              style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
              decoration: InputDecoration(
                hintText: 'Search seeds...',
                hintStyle: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
                prefixIcon: Icon(
                  Icons.search,
                  color: ThemeHelper.textSecondaryColor(context),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.filters.length,
              itemBuilder: (context, index) {
                final filter = controller.filters[index];
                return _FilterChip(
                  label: filter,
                  controller: controller,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, HistoryController controller) {
    return Obx(() {
      final filtered = controller.filteredHistory;

      if (filtered.isEmpty) {
        return const EmptyState(
          icon: Icons.inbox_rounded,
          title: 'No results found',
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filtered.length,
        itemBuilder: (context, index) => HistoryTile(result: filtered[index]),
      );
    });
  }

  void _showClearDialog(BuildContext context, HistoryController controller) {
    Get.dialog(
      AlertDialog(
        backgroundColor: ThemeHelper.cardColor(context),
        title: Text(
          'Clear History',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        content: Text(
          'Are you sure you want to delete all scan history?',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.clearHistory();
              Get.back();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final HistoryController controller;

  const _FilterChip({
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == label;

      return GestureDetector(
        onTap: () => controller.setFilter(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : ThemeHelper.cardColor(context),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : ThemeHelper.textSecondaryColor(context).withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : ThemeHelper.textPrimaryColor(context),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }
}