import 'package:intl/intl.dart';

class DateHelper {
  static String timeAgo(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inSeconds < 60) {
      final int seconds = difference.inSeconds;
      return "$seconds ${seconds == 1 ? 'second' : 'seconds'} ago";
    } else if (difference.inMinutes < 60) {
      final int minutes = difference.inMinutes;
      return "$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago";
    } else if (difference.inHours < 24) {
      final int hours = difference.inHours;
      return "$hours ${hours == 1 ? 'hour' : 'hours'} ago";
    } else if (difference.inDays < 7) {
      final int days = difference.inDays;
      return "$days ${days == 1 ? 'day' : 'days'} ago";
    } else if (difference.inDays < 30) {
      final int weeks = (difference.inDays / 7).floor();
      return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
    } else if (difference.inDays < 365) {
      final int months = (difference.inDays / 30).floor();
      return "$months ${months == 1 ? 'month' : 'months'} ago";
    } else {
      final int years = (difference.inDays / 365).floor();
      return "$years ${years == 1 ? 'year' : 'years'} ago";
    }
  }

  static String formatDate(DateTime? dateTime, DateFormatEnum format) {
    switch (format) {
      case DateFormatEnum.yyyyMmDd:
        return DateFormat('yyyy-MM-dd').format(dateTime ?? DateTime.now());
      case DateFormatEnum.mmDdYyyy:
        return DateFormat('MMMM dd, yyyy').format(dateTime ?? DateTime.now());
      case DateFormatEnum.ddMmYyyy:
        return DateFormat('dd MMMM yyyy').format(dateTime ?? DateTime.now());
      case DateFormatEnum.yyyyMmDdHhMmSs:
        return DateFormat(
          'yyyy-MM-dd HH:mm:ss',
        ).format(dateTime ?? DateTime.now());
      case DateFormatEnum.mmDdYyyyHhMmSs:
        return DateFormat(
          'MMMM dd, yyyy HH:mm:ss',
        ).format(dateTime ?? DateTime.now());
      case DateFormatEnum.ddMmYyyyHhMmSs:
        return DateFormat(
          'dd MMMM yyyy HH:mm:ss',
        ).format(dateTime ?? DateTime.now());
    }
  }

  static String generateCheerfulGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good morning 🌤️";
    } else if (hour >= 12 && hour < 17) {
      return "Good afternoon ☀️";
    } else if (hour >= 17 && hour < 21) {
      return "Good evening 🌇";
    } else {
      return "Good night 🌙";
    }
  }
}

enum DateFormatEnum {
  yyyyMmDd,
  mmDdYyyy,
  ddMmYyyy,
  yyyyMmDdHhMmSs,
  mmDdYyyyHhMmSs,
  ddMmYyyyHhMmSs,
}
