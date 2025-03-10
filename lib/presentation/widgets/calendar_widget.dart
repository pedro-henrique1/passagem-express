import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passagem_express/presentation/controller/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:passagem_express/presentation/controller/ticket_type_controller.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget({
    super.key,
    required this.onDateRangeSelected,
    required this.onSingleDateSelected,
  });
  final Function(DateTimeRange) onDateRangeSelected;
  final Function(DateTime) onSingleDateSelected;

  final TicketTypeController ticketController = Get.put(TicketTypeController());
  final CalendarController calendarController = Get.put(CalendarController());

  void _showCalendarModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 300,
            height: 400,
            child: TableCalendar(
              focusedDay: calendarController.focusedDay.value,
              firstDay: DateTime.now(),
              lastDay: DateTime(2100),
              selectedDayPredicate: (day) => _isSelected(day),
              onDaySelected: (selectedDay, focusedDay) {
                _handleDaySelection(selectedDay, focusedDay);
                Navigator.pop(context);
                _showCalendarModal(context);
              },
              onFormatChanged: (format) {},
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                todayDecoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
                rangeHighlightColor: Colors.blue.withOpacity(0.3),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isSelected(DateTime day) {
    if (ticketController.selectedTicketType.value == SingingCharacter.Ida) {
      return calendarController.selectedDay.value == day;
    }

    final range = ticketController.selectedDateRange.value;
    if (range != null) {
      return day.isAfter(range.start.subtract(const Duration(days: 1))) &&
          day.isBefore(range.end.add(const Duration(days: 1)));
    }

    return false;
  }

  void _handleDaySelection(DateTime selectDay, DateTime focusedDay) {
    calendarController.focusedDay.value = focusedDay;
    calendarController.selectedDay.value = selectDay;

    // Lógica para ida e volta
    if (ticketController.selectedTicketType.value ==
        SingingCharacter.IdaVolta) {
      final currentRange = ticketController.selectedDateRange.value;

      if (currentRange == null || selectDay.isBefore(currentRange.start)) {
        ticketController.selectedDateRange.value = DateTimeRange(
          start: selectDay,
          end: selectDay,
        );
      } else {
        ticketController.selectedDateRange.value = DateTimeRange(
          start: currentRange.start,
          end: selectDay,
        );
      }
    } else {
      ticketController.selectedDateRange.value = DateTimeRange(
        start: selectDay,
        end: selectDay.add(const Duration(days: 1)),
      );
    }

    onSingleDateSelected(selectDay);

    final range = ticketController.selectedDateRange.value;
    if (range != null && range.start != range.end) {
      onDateRangeSelected(range);
    }
  }

  String _getFormattedDateRange() {
    final range = ticketController.selectedDateRange.value;
    if (range == null) {
      return 'Selecione a data de ida ou ida e volta';
    }

    final start = '${range.start.day}/${range.start.month}/${range.start.year}';
    final end = '${range.end.day}/${range.end.month}/${range.end.year}';

    return ticketController.selectedTicketType.value == SingingCharacter.Ida
        ? start
        : '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCalendarModal(context),
      child: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_month_rounded),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  _getFormattedDateRange(),
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
