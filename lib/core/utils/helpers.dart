import 'package:intl/intl.dart';

abstract class Helpers {
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy • h:mm a').format(date);
  }

  static String formatDateLong(DateTime date) {
    return DateFormat('MMMM d, yyyy • h:mm a').format(date);
  }

  static String formatConfidence(double confidence) {
    return '${(confidence * 100).toStringAsFixed(1)}%';
  }

  static String formatConfidenceShort(double confidence) {
    return '${(confidence * 100).toStringAsFixed(0)}%';
  }
}