import 'package:medapp/toast.dart';

class CalendarDayModel {
  String dayLetter;
  int dayNumber;
  int month;
  int year;
  bool isChecked;

  CalendarDayModel(
      {this.dayLetter = 'M',
      this.dayNumber = 1,
      this.year = 2023,
      this.month = 11,
      this.isChecked = false});

  static final List<String> dayNames = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ];

  //----------------| get current 7 days |----------------------
  List<CalendarDayModel> getCurrentDays() {
    final List<CalendarDayModel> daysList = [];
    DateTime currentTime = DateTime.now();
    // currentTime = currentTime.add(Duration(days: 1));
    for (int i = 0; i < 7; i++) {
      daysList.add(CalendarDayModel(
          dayLetter: getDayLetter(currentTime.weekday),
          dayNumber: currentTime.day,
          month: currentTime.month,
          year: currentTime.year,
          isChecked: false));
      currentTime = currentTime.add(Duration(days: 1));
    }
    daysList[0].isChecked = true;
    return daysList;
  }

  String getDayLetter(int weekday) {
    return dayNames[weekday % 7];
  }
  //============================================================
}
