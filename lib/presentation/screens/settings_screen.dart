import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../controllers/history_controller.dart';
import '../widgets/common/icon_box.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, 'Appearance', [_buildThemeToggle(context)]),
            const SizedBox(height: 24),
            _buildSection(context, 'Data', _buildDataTiles(context)),
            const SizedBox(height: 24),
            _buildSection(context, 'About', _buildAboutTiles()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final controller = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(
      builder: (_) => SwitchListTile(
        title: const Text('Dark Mode'),
        subtitle: const Text('Toggle dark/light theme'),
        secondary: IconBox(
          icon: controller.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Theme.of(context).colorScheme.primary,
        ),
        value: controller.isDarkMode,
        onChanged: (_) => controller.toggleTheme(),
      ),
    );
  }

  List<Widget> _buildDataTiles(BuildContext context) {
    final history = Get.find<HistoryController>();

    return [
      Obx(() => ListTile(
        leading: const IconBox(icon: Icons.storage, color: Colors.blue),
        title: const Text('Storage Used'),
        subtitle: Text('${history.totalScans} scans saved'),
      )),
      const Divider(height: 1),
      ListTile(
        leading: const IconBox(icon: Icons.delete_forever, color: Colors.red),
        title: const Text('Clear All Data'),
        subtitle: const Text('Delete all scans and history'),
        onTap: () => _showClearDialog(context),
      ),
    ];
  }

  List<Widget> _buildAboutTiles() {
    return const [
      ListTile(
        leading: IconBox(icon: Icons.info_outline, color: Colors.green),
        title: Text('Version'),
        subtitle: Text('1.0.0'),
      ),
      Divider(height: 1),
      ListTile(
        leading: IconBox(icon: Icons.psychology, color: Colors.purple),
        title: Text('AI Model'),
        subtitle: Text('TensorFlow Lite - Seed Classification'),
      ),
      Divider(height: 1),
      ListTile(
        leading: IconBox(icon: Icons.grass, color: Colors.orange),
        title: Text('Supported Seeds'),
        subtitle: Text('8 different seed types'),
      ),
    ];
  }

  void _showClearDialog(BuildContext context) {
    final history = Get.find<HistoryController>();

    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your scan history. This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              history.clearHistory();
              Get.back();
              Get.snackbar(
                'Success',
                'All data has been cleared',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}