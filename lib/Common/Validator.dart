class Validator {
  static bool checkSpecialCharacter(String text) {
    if (text.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkUpperCase(String text) {
    if (text.contains(new RegExp(r'[A-Z]'))) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkLowerCase(String text) {
    if (text.contains(new RegExp(r'[a-z]'))) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkNumber(String text) {
    if (text.contains(new RegExp(r'[0-9]'))) {
      return true;
    } else {
      return false;
    }
  }

  static int checkValidDOB(String text) {
    String day = text[0] + text[1];
    String month = text[3] + text[4];
    String year = text[6] + text[7] + text[8] + text[9];

    DateTime today = DateTime.now();

    var dobRegex = '/^(((0[1-9]|[12][0-9]|30)[-/]?(0[13-9]|1[012])|31[-/]?(0[13578]|1[02])|(0[1-9]|1[0-9]|2[0-8])[-/]?02)[-/]?[0-9]{4}|29[-/]?02[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))\$/';

    int dayInt = int.parse(day);
    int monthInt = int.parse(month);
    int yearInt = int.parse(year);

    if (text.length != 10) {
      return 4;
    } else if (text[2] != '/' || text[5] != '/') {
      return 5;
    } else if (text.contains(dobRegex)) {
      return 1;
    } else if (yearInt > today.year) {
      return 2;
    } else if (yearInt == today.year) {
      if (monthInt == today.month) {
        if (dayInt >= today.day) {
          return 3;
        } else if (monthInt > today.month) {
          return 3;
        }
      }
    }

    return 0;
  }
}
