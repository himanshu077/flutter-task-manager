import 'package:intl/intl.dart';

class DateTimeUtils {
  //get time stamp of length 13...
  static int get getCurrentTimeStamp => DateTime.now().millisecondsSinceEpoch;

  static int getTimeStamp(DateTime date) => date.millisecondsSinceEpoch;

  // convert timeStamp to format string ....
  static String stampToPattern(int timeStamp, String pattern) =>
      dateTimeToPattern(stampToDateTime(timeStamp), pattern);

  // convert time stamp to dateTime .....
  static DateTime stampToDateTime(int timeStamp) =>
      DateTime.fromMillisecondsSinceEpoch(timeStamp);

  // convert string to dateTime .... returns DateTime
  static DateTime patternToDateTime(String value, String pattern) =>
      DateFormat(pattern).parse(value);

  // convert dateTime to string pattern .... returns String
  static String dateTimeToPattern(DateTime dTime, String pattern) =>
      DateFormat(pattern).format(dTime);
}

class DateTimePattern {
  static const String dd_MM_yyyy_HHmm = 'dd-MM-yyyy HH:mm'; //08-12-2023 12:00
  static const String ddMMMyyyy_hhmma =
      'dd MMM yyyy, hh:mm a'; //08-12-2023 12:00
  static const String dd_MMM_yyyy_hhmma =
      'dd-MMM-yyyy hh:mm a'; //08-12-2023 12:00
  static const String ddMMyyyy = 'dd-MM-yyyy'; //08-12-2023
  static const String dd_MMM_yyyy = 'dd-MMM-yyyy'; //08-12-2023
  static const String HHmm = 'HH:mm'; //12:00
  static const String hhmma = 'hh:mm a'; //12:00
}

// ' 12 Dec 2024, 12:30 PM'

// Extension
extension StampToPatternExtension on int {
  String get dd_MM_yyyy_HHmm =>
      DateTimeUtils.stampToPattern(this, DateTimePattern.dd_MM_yyyy_HHmm);

  String get ddMMMyyyy_hhmma =>
      DateTimeUtils.stampToPattern(this, DateTimePattern.ddMMMyyyy_hhmma);

  String get ddMMyyyy =>
      DateTimeUtils.stampToPattern(this, DateTimePattern.ddMMyyyy);

  String get dd_MMM_yyyy =>
      DateTimeUtils.stampToPattern(this, DateTimePattern.dd_MMM_yyyy);

  String get HHss => DateTimeUtils.stampToPattern(this, DateTimePattern.HHmm);

  String get hhmma => DateTimeUtils.stampToPattern(this, DateTimePattern.hhmma);
}

// Extension
extension DateTimeExtension on DateTime {
  int get timeStamp => DateTimeUtils.getTimeStamp(this);

  String get dd_MMM_yyyy =>
      DateTimeUtils.dateTimeToPattern(this, DateTimePattern.dd_MMM_yyyy);
}

// Extension
extension StringDateTimeExtension on String {
  int get timeStamp_from_dd_MMM_yyyy_hhmma =>
      DateTimeUtils.patternToDateTime(this, DateTimePattern.dd_MMM_yyyy_hhmma)
          .timeStamp;

  bool get isDate {
    try {
      DateTimeUtils.patternToDateTime(this, DateTimePattern.dd_MMM_yyyy);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get isTime {
    try {
      DateTimeUtils.patternToDateTime(this, DateTimePattern.hhmma);
      return true;
    } catch (e) {
      return false;
    }
  }
}
