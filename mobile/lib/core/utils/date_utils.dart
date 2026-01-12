import 'package:intl/intl.dart';

/// Date utilities with timezone-safe parsing
/// Based on web app's fix for timezone issues (commit 4dbcb48)
class AppDateUtils {
  /// Parse date string as local date (not UTC)
  /// Prevents timezone shift issues when date strings like "2026-01-08"
  /// are interpreted as UTC
  ///
  /// Reference: client/src/utils/analytics.js:8-15
  static DateTime? parseLocalDate(String? dateString) {
    if (dateString == null || dateString.trim().isEmpty) return null;

    final parts = dateString.split('-');
    if (parts.length != 3) return null;

    try {
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  /// Format date as YYYY-MM-DD (local timezone)
  static String formatLocalDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Format date for display (e.g., "Jan 8, 2026")
  static String formatDisplayDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('MMM d, y').format(date);
  }

  /// Calculate days between two dates (timezone-safe)
  static int daysBetween(DateTime from, DateTime to) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);
    return toDate.difference(fromDate).inDays;
  }

  /// Get today's date at midnight (local timezone)
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(today);
  }

  /// Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(today);
  }
}
