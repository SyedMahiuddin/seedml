import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/theme_helper.dart';
import '../controllers/theme_controller.dart';
import '../controllers/history_controller.dart';
import '../widgets/common/icon_box.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, 'Appearance', [_buildThemeToggle(context)]),
            const SizedBox(height: 24),
            _buildSection(context, 'Data', _buildDataTiles(context)),
            const SizedBox(height: 24),
            _buildSection(context, 'About', _buildAboutTiles(context)),
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
            color: ThemeHelper.cardColor(context),
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
        title: Text(
          'Dark Mode',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        subtitle: Text(
          'Toggle dark/light theme',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
        ),
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
        title: Text(
          'Storage Used',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        subtitle: Text(
          '${history.totalScans} scans saved',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
        ),
      )),
      Divider(height: 1, color: ThemeHelper.textSecondaryColor(context).withOpacity(0.2)),
      ListTile(
        leading: const IconBox(icon: Icons.delete_forever, color: Colors.red),
        title: Text(
          'Clear All Data',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        subtitle: Text(
          'Delete all scans and history',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
        ),
        onTap: () => _showClearDialog(context),
      ),
    ];
  }

  List<Widget> _buildAboutTiles(BuildContext context) {
    return [
      ListTile(
        leading: const IconBox(icon: Icons.info_outline, color: Colors.green),
        title: Text(
          'Version',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        subtitle: Text(
          '1.0.0',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
        ),
      ),
      Divider(height: 1, color: ThemeHelper.textSecondaryColor(context).withOpacity(0.2)),
      ListTile(
        leading: const IconBox(icon: Icons.psychology, color: Colors.purple),
        title: Text(
          'AI Model',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        subtitle: Text(
          'TensorFlow Lite - Seed Classification',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
        ),
      ),
      Divider(height: 1, color: ThemeHelper.textSecondaryColor(context).withOpacity(0.2)),
      ListTile(
        leading: const IconBox(icon: Icons.grass, color: Colors.orange),
        title: Text(
          'Supported Seeds',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        subtitle: Text(
          '8 different seed types',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
        ),
      ),
    ];
  }

  void _showClearDialog(BuildContext context) {
    final history = Get.find<HistoryController>();

    Get.dialog(
      AlertDialog(
        backgroundColor: ThemeHelper.cardColor(context),
        title: Text(
          'Clear All Data',
          style: TextStyle(color: ThemeHelper.textPrimaryColor(context)),
        ),
        content: Text(
          'This will permanently delete all your scan history. This action cannot be undone.',
          style: TextStyle(color: ThemeHelper.textSecondaryColor(context)),
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