import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SingingCharacter { Ida, IdaVolta }

class TicketTypeController extends GetxController {
  var selectedTicketType = SingingCharacter.Ida.obs;
  var selectedDateRange = Rxn<DateTimeRange>();

  void updateTicketType(SingingCharacter type) {
    selectedTicketType.value = type;
    if (type == SingingCharacter.Ida || type == SingingCharacter.IdaVolta) {
      selectedDateRange.value = null;
    }
  }

  void updateDateRange(DateTimeRange range) {
    if (selectedTicketType.value == SingingCharacter.IdaVolta) {
      selectedDateRange.value = range;
    } else {
      selectedDateRange.value = DateTimeRange(
        start: range.start,
        end: range.start,
      );
    }
  }
}
