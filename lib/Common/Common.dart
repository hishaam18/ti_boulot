class Common {
  static String userID;
  static var taskData;

  static List<String> avatars = [
    'avatar1.png',
    'avatar2.png',
    'avatar3.png',
    'avatar4.png',
    'avatar5.png',
    'avatar6.png',
    'avatar7.png',
    'avatar8.png',
    'avatar9.png',
  ];

  static List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
}

class DateAndTime {
  //Flutter date --> 2021-06-16 02:43:26.365852
  //SQL date --> 2021-06-16 02:43:26

  static String flutterToSqlDate(DateTime date) {
    String rawDate = date.toString();

    String year = rawDate[0] + rawDate[1] + rawDate[2] + rawDate[3];
    String month = rawDate[5] + rawDate[6];
    String day = rawDate[8] + rawDate[9];
    String hour = rawDate[11] + rawDate[12];
    String minute = rawDate[14] + rawDate[15];
    String second = rawDate[17] + rawDate[18];

    String newDate = year +
        "-" +
        month +
        "-" +
        day +
        " " +
        hour +
        ":" +
        minute +
        ":" +
        second;
    return newDate;
  }

  static DateTime sqlToFlutterDate(String date) {
    date.replaceAll("T", " ");
    date.replaceAll("Z", "");
    DateTime newDate = DateTime.parse(date);
    return newDate;
  }

  static bool compareFlutterDates(DateTime first, DateTime last) {
    if (first.compareTo(last) > 0)
      return true;
    else
      return false;
  }

  String getTimeFromTimestamp(String timeStamp) {
    String time = timeStamp[11] +
        timeStamp[12] +
        timeStamp[13] +
        timeStamp[14] +
        timeStamp[15];
    return time;
  }

  String getDateFromTimestamp(String timeStamp) {
    String dayString = timeStamp[8] + timeStamp[9];
    String monthString = timeStamp[5] + timeStamp[6];
    String yearString =
        timeStamp[0] + timeStamp[1] + timeStamp[2] + timeStamp[3];

    int dayInt = int.parse(dayString);
    int monthInt = int.parse(monthString);
    int yearInt = int.parse(yearString);

    String date = dayInt.toString() +
        " " +
        Common.months[monthInt - 1] +
        " " +
        yearInt.toString();

    return date;
  }
}
