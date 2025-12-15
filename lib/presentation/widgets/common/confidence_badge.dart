import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';

class ConfidenceBadge extends StatelessWidget {
  final double confidence;
  final bool showPercentSign;
  final double fontSize;

  const ConfidenceBadge({
    super.key,
    required this.confidence,
    this.showPercentSign = true,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getConfidenceColor(confidence);
    final text = showPercentSign
        ? Helpers.formatConfidenceShort(confidence)
        : '${(confidence * 100).toStringAsFixed(0)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}