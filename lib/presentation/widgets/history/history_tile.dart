import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_helper.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/scan_result.dart';
import '../../controllers/history_controller.dart';

class HistoryTile extends StatelessWidget {
  final ScanResult result;

  const HistoryTile({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryController>();

    return Dismissible(
      key: Key(result.id),
      direction: DismissDirection.endToStart,
      background: _buildDeleteBackground(),
      onDismissed: (_) => controller.deleteResult(result.id),
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.resultDetail, arguments: result),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeHelper.cardColor(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Hero(
                tag: 'image_${result.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(result.imagePath),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: _buildInfo(context)),
              const SizedBox(width: 12),
              _buildActions(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 70,
      height: 70,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported),
    );
  }

  Widget _buildInfo(BuildContext context) {
    final confidenceColor = AppColors.getConfidenceColor(result.confidence);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          result.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeHelper.textPrimaryColor(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          Helpers.formatDate(result.timestamp),
          style: TextStyle(
            fontSize: 12,
            color: ThemeHelper.textSecondaryColor(context),
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: result.confidence,
          backgroundColor: confidenceColor.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation(confidenceColor),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, HistoryController controller) {
    return Obx(() {
      final current = controller.getResultById(result.id);
      final isFavorite = current?.isFavorite ?? false;

      return Column(
        children: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : ThemeHelper.textSecondaryColor(context),
            ),
            onPressed: () => controller.toggleFavorite(result.id),
          ),
          Text(
            Helpers.formatConfidenceShort(result.confidence),
            style: TextStyle(
              color: AppColors.getConfidenceColor(result.confidence),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    });
  }
}