DateTime dateNow = DateTime.now();

String getDayName(int weekday) {
  switch (weekday) {
    case DateTime.saturday:
      return "Sat";
    case DateTime.sunday:
      return "Sun";
    case DateTime.monday:
      return "Mon";
    case DateTime.tuesday:
      return "Tue";
    case DateTime.wednesday:
      return "Wed";
    case DateTime.thursday:
      return "Thu";
    case DateTime.friday:
      return "Fri";
    case _:
      return "Unkwon";
  }
}

String getDayNumber(int day) {
  return "$day".length == 1 ? "0$day" : "$day";
}

String getMonthName(int month) {
  switch (month) {
    case DateTime.january:
      return "January";
    case DateTime.february:
      return "February";
    case DateTime.march:
      return "March";
    case DateTime.april:
      return "April";
    case DateTime.may:
      return "May";
    case DateTime.june:
      return "June";
    case DateTime.july:
      return "July";
    case DateTime.august:
      return "August";
    case DateTime.september:
      return "September";
    case DateTime.october:
      return "October";
    case DateTime.november:
      return "November";
    case DateTime.december:
      return "December";
    case _:
      return "Unkwon";
  }
}

int getYear() => dateNow.year;

String generateDayInfo() {
  return "${getDayName(dateNow.weekday)}, ${getDayNumber(dateNow.day)} ${getMonthName(dateNow.month)} ${getYear()}";
}
