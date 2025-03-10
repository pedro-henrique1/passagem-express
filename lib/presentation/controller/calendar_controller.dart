import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  var selectedDateRange = Rxn<DateTimeRange>();
  var selectedDay = Rxn<DateTime>();
  var focusedDay = DateTime.now().obs;

  void onDaySelected(DateTime day, DateTime focusedDay) {
    this.focusedDay.value = focusedDay;

    if (selectedDateRange.value == null ||
        selectedDateRange.value!.start == selectedDateRange.value!.end) {
      selectedDateRange.value = DateTimeRange(start: day, end: day);
      selectedDay.value = day;
    } else {
      if (day.isBefore(selectedDateRange.value!.start)) {
        selectedDateRange.value = DateTimeRange(
          start: day,
          end: selectedDateRange.value!.end,
        );
      } else if (day.isAfter(selectedDateRange.value!.end)) {
        selectedDateRange.value = DateTimeRange(
          start: selectedDateRange.value!.start,
          end: day,
        );
      } else {
        selectedDateRange.value = DateTimeRange(
          start: selectedDateRange.value!.start,
          end: day,
        );
      }
    }
  }

  void setDateRange(DateTime start, DateTime end) {
    selectedDateRange.value = DateTimeRange(start: start, end: end);
  }

  void clearSelection() {
    selectedDateRange.value = null;
    selectedDay.value = null;
  }
}
