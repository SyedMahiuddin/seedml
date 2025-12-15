import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text('Scan History'),
        actions: [
          Obx(() => controller.history.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: () => _showClearDialog(context, controller),
          )
              : const SizedBox()),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(context, controller),
          Expanded(child: _buildHistoryList(controller)),
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
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: const InputDecoration(
                hintText: 'Search seeds...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.filters.value.length,
              itemBuilder: (context, index) {
                var selected=controller.selectedFilter.value;
                final filter = controller.filters.value[index];
                final isSelected = controller.selectedFilter.value == filter;
                return _FilterChip(
                  label: filter,
                  isSelected: isSelected,
                  onTap: () => controller.selectedFilter.value = filter,
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(HistoryController controller) {
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
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to delete all scan history?'),
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
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}