import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/seed_data.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/scan_result.dart';
import '../controllers/classifier_controller.dart';
import '../controllers/history_controller.dart';
import '../widgets/common/info_tile.dart';

class ResultDetailScreen extends StatelessWidget {
  const ResultDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = Get.arguments as ScanResult;
    final info = SeedData.getInfo(result.label);
    final color = info?.color ?? Colors.green;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, result),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, result),
                  const SizedBox(height: 24),
                  _buildConfirmationCard(result, color),
                  const SizedBox(height: 24),
                  _buildSeedInfo(context, info),
                  const SizedBox(height: 24),
                  _buildActions(context, result, color),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, ScanResult result) {
    final history = Get.find<HistoryController>();

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'image_${result.id}',
          child: Image.file(
            File(result.imagePath),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported, size: 64),
            ),
          ),
        ),
      ),
      leading: _CircleButton(
        icon: Icons.arrow_back,
        onTap: Get.back,
      ),
      actions: [
        Obx(() {
          final current = history.getResultById(result.id);
          final isFavorite = current?.isFavorite ?? false;
          return _CircleButton(
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            iconColor: isFavorite ? Colors.red : Colors.white,
            onTap: () => history.toggleFavorite(result.id),
          );
        }),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, ScanResult result) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result.label,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                Helpers.formatDateLong(result.timestamp),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.getConfidenceColor(result.confidence).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            Helpers.formatConfidence(result.confidence),
            style: TextStyle(
              color: AppColors.getConfidenceColor(result.confidence),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationCard(ScanResult result, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Icons.verified, color: Colors.white, size: 48),
          const SizedBox(height: 12),
          const Text(
            'Identification Complete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AI Confidence: ${Helpers.formatConfidence(result.confidence)}',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSeedInfo(BuildContext context, SeedInfo? info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seed Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        InfoTile(
          title: 'Scientific Name',
          value: info?.scientificName ?? 'N/A',
          icon: Icons.science,
        ),
        InfoTile(
          title: 'Family',
          value: info?.family ?? 'N/A',
          icon: Icons.account_tree,
        ),
        InfoTile(
          title: 'Growth Time',
          value: info?.growthTime ?? 'N/A',
          icon: Icons.schedule,
        ),
        InfoTile(
          title: 'Best Season',
          value: info?.season ?? 'N/A',
          icon: Icons.wb_sunny,
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, ScanResult result, Color color) {
    final history = Get.find<HistoryController>();
    final classifier = Get.find<ClassifierController>();

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Get.back();
              classifier.pickAndClassify(ImageSource.camera);
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text('Scan Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              history.deleteResult(result.id);
              Get.back();
              Get.snackbar(
                'Deleted',
                'Scan has been removed',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor ?? Colors.white),
        onPressed: onTap,
      ),
    );
  }
}