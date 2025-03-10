import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passagem_express/presentation/controller/airport_controller.dart';
import 'package:passagem_express/presentation/controller/airport_dropdown_controller.dart';

import 'package:passagem_express/presentation/widgets/calendar_widget.dart';
import 'package:passagem_express/presentation/widgets/custom_text_field_with_suggestions.dart';

class AirportDropdown extends StatelessWidget {
  AirportDropdown({super.key});

  final airportDropdownController = Get.put(AirportDropdownController());
  final airportController = Get.put(AirportController());

  void _onDateRangeSelected(DateTimeRange range) {}

  void _onSingleDateSelected(DateTime date) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFieldWithOverlay(
            controller: airportDropdownController.originController,
            focusNode: airportDropdownController.originFocus,
            icon: Icons.flight_takeoff,
            hint: 'Origem',
            onChanged: (query) {
              airportController.searchAirports(query);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo de origem é obrigatório';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextFieldWithOverlay(
            controller: airportDropdownController.destinationController,
            focusNode: airportDropdownController.destinationFocus,
            icon: Icons.flight_land,
            hint: 'Destino',
            onChanged: (query) {
              airportController.searchAirports(query);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo de destino é obrigatório';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CalendarWidget(
            onDateRangeSelected: _onDateRangeSelected,
            onSingleDateSelected: _onSingleDateSelected,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
