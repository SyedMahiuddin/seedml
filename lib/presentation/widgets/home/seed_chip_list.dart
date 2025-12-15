import 'package:flutter/material.dart';
import '../../../core/constants/seed_data.dart';
import '../../../core/theme/theme_helper.dart';

class SeedChipList extends StatelessWidget {
  const SeedChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Supported Seeds',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ThemeHelper.textPrimaryColor(context),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: SeedData.labels.length,
            itemBuilder: (context, index) {
              final seed = SeedData.labels[index];
              final info = SeedData.getInfo(seed);
              return _SeedChip(name: seed, color: info?.color ?? Colors.green);
            },
          ),
        ),
      ],
    );
  }
}

class _SeedChip extends StatelessWidget {
  final String name;
  final Color color;

  const _SeedChip({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ThemeHelper.cardColor(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.grass, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ThemeHelper.textPrimaryColor(context),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}