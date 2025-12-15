import 'package:flutter/material.dart';

class SeedInfo {
  final String name;
  final String scientificName;
  final String family;
  final String growthTime;
  final String season;
  final Color color;

  const SeedInfo({
    required this.name,
    required this.scientificName,
    required this.family,
    required this.growthTime,
    required this.season,
    required this.color,
  });
}

abstract class SeedData {
  static const List<String> labels = [
    'Bitter Gourd',
    'Bottle Gourd',
    'Hyacinth Bean',
    'Malabar Spinach Seeds',
    'Okra Seeds',
    'String Beans',
    'Sunflower Seeds',
    'Watermelon Seeds',
  ];

  static const Map<String, SeedInfo> info = {
    'Bitter Gourd': SeedInfo(
      name: 'Bitter Gourd',
      scientificName: 'Momordica charantia',
      family: 'Cucurbitaceae',
      growthTime: '55-60 days',
      season: 'Summer',
      color: Color(0xFF4CAF50),
    ),
    'Bottle Gourd': SeedInfo(
      name: 'Bottle Gourd',
      scientificName: 'Lagenaria siceraria',
      family: 'Cucurbitaceae',
      growthTime: '60-70 days',
      season: 'Summer',
      color: Color(0xFF8BC34A),
    ),
    'Hyacinth Bean': SeedInfo(
      name: 'Hyacinth Bean',
      scientificName: 'Lablab purpureus',
      family: 'Fabaceae',
      growthTime: '90-120 days',
      season: 'Monsoon',
      color: Color(0xFF9C27B0),
    ),
    'Malabar Spinach Seeds': SeedInfo(
      name: 'Malabar Spinach Seeds',
      scientificName: 'Basella alba',
      family: 'Basellaceae',
      growthTime: '45-60 days',
      season: 'Summer',
      color: Color(0xFF2E7D32),
    ),
    'Okra Seeds': SeedInfo(
      name: 'Okra Seeds',
      scientificName: 'Abelmoschus esculentus',
      family: 'Malvaceae',
      growthTime: '50-65 days',
      season: 'Summer',
      color: Color(0xFFFF9800),
    ),
    'String Beans': SeedInfo(
      name: 'String Beans',
      scientificName: 'Phaseolus vulgaris',
      family: 'Fabaceae',
      growthTime: '50-60 days',
      season: 'Spring',
      color: Color(0xFF00BCD4),
    ),
    'Sunflower Seeds': SeedInfo(
      name: 'Sunflower Seeds',
      scientificName: 'Helianthus annuus',
      family: 'Asteraceae',
      growthTime: '70-100 days',
      season: 'Summer',
      color: Color(0xFFFFC107),
    ),
    'Watermelon Seeds': SeedInfo(
      name: 'Watermelon Seeds',
      scientificName: 'Citrullus lanatus',
      family: 'Cucurbitaceae',
      growthTime: '70-90 days',
      season: 'Summer',
      color: Color(0xFFE91E63),
    ),
  };

  static SeedInfo? getInfo(String label) => info[label];
}