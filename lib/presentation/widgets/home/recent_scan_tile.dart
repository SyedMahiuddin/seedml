import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/theme_helper.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/scan_result.dart';
import '../common/confidence_badge.dart';

class RecentScanTile extends StatelessWidget {
  final ScanResult result;

  const RecentScanTile({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(result.imagePath),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholder(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
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
                ],
              ),
            ),
            ConfidenceBadge(confidence: result.confidence),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported),
    );
  }
}