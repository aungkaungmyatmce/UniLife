import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const DAY_MONTH_YEAR = "dd-MM-yyyy";
const DAY_MONTH_YEAR_2 = "dd MMM yyyy";
const DAY_MONTH_YEAR_HH_MM_SS = "dd-MMM-yyyy HH:mm aa";
const YEAR_MONTH_DAY = "yyyy-MM-dd";
const HOUR_MINUTE = "HH:mm";
const HOUR_MINUTE_SECOND = "HH:mm:ss";

class DateUtil {
  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  static convertDateFormat(String originalDate, String pattern) {
    if (originalDate == null) return originalDate;
    try {
      return DateFormat(pattern).format(DateTime.parse(originalDate));
    } catch (e) {
      return originalDate;
    }
  }

  static String timeOfDayTo24Hrs(String originalTime) {
    try {
      return DateFormat(HOUR_MINUTE)
          .format(DateFormat.jm().parse(originalTime));
    } catch (e) {
      return originalTime;
    }
  }

  static String hrsToTimeOfDay(String originalTime, context) {
    try {
      DateTime dateTime = DateFormat(HOUR_MINUTE_SECOND).parse(originalTime);
      return TimeOfDay.fromDateTime(dateTime).format(context);
    } catch (e) {
      return originalTime;
    }
  }

  static String convertTimeAgoFromTimestamp(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      //return '${difference.inSeconds} seconds ago';
      return 'Just Now';
    } else {
      return 'Just Now';
    }
  }
}
