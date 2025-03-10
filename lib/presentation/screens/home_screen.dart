import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passagem_express/presentation/controller/airport_controller.dart';
import 'package:passagem_express/presentation/controller/airport_dropdown_controller.dart';
import 'package:passagem_express/presentation/controller/calendar_controller.dart';
import 'package:passagem_express/presentation/controller/ticket_type_controller.dart';
import 'package:passagem_express/presentation/controller/viajantes_controller.dart';
import 'package:passagem_express/presentation/screens/flight_selection_screen.dart';
import 'package:passagem_express/presentation/widgets/airport_dropdown.dart';
import 'package:passagem_express/presentation/widgets/button_type.dart';
import 'package:passagem_express/presentation/widgets/count_down.dart';
import 'package:passagem_express/presentation/widgets/drop_down_companies.dart';
import 'package:passagem_express/services/airport_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viajanteController = Get.put(ViajantesController());
  final calendarController = Get.put(CalendarController());
  final ticketController = Get.put(TicketTypeController());
  final airportController = Get.put(AirportController());
  final ticketService = Get.put(AirportService());
  final destAndOrigin = Get.put(AirportDropdown());
  final companies = Get.put(DropdownController());
  final airportDropdownController = Get.put(AirportDropdownController());

  void _sendTicketData() {
    if (_validateForm()) {
      final data = _buildTicketData();

      ticketService.createTicket(data).then((ticketId) {
        if (ticketId == null) {
          throw Exception('Erro ao buscar voos');
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlightSelectionScreen(ticketId: ticketId),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool _validateForm() {
    final originAirport = airportDropdownController.originController.text;
    final destinationAirport =
        airportDropdownController.destinationController.text;
    final dateIda = ticketController.selectedDateRange.value?.start;
    final dateVolta = ticketController.selectedDateRange.value?.end;
    final companhias = companies.selectedAirlines;

    return originAirport.isNotEmpty &&
        destinationAirport.isNotEmpty &&
        dateIda != null &&
        dateVolta != null &&
        originAirport != destinationAirport &&
        companhias.isNotEmpty;
  }

  Map<String, Object?> _buildTicketData() {
    final originAirport = airportDropdownController.originController.text;
    final destinationAirport =
        airportDropdownController.destinationController.text;

    final dateIda =
        ticketController.selectedDateRange.value?.start != null
            ? DateFormat(
              'dd/MM/yyyy',
            ).format(ticketController.selectedDateRange.value!.start)
            : null;

    final dateVolta =
        ticketController.selectedDateRange.value?.end != null
            ? DateFormat(
              'dd/MM/yyyy',
            ).format(ticketController.selectedDateRange.value!.end)
            : null;

    String extractIATA(String airportInfo) {
      List<String> parts = airportInfo.split(', ');
      String iataCode = parts.length > 1 ? parts[1].split(' ')[0] : '';
      return iataCode.isNotEmpty ? iataCode : '';
    }

    final tipo =
        ticketController.selectedTicketType.value.toString().split('.').last;
    final companhias = companies.selectedAirlines;

    final ticketData = {
      "Companhias": companhias,
      "DataIda": dateIda,
      "DataVolta": dateVolta,
      "Origem": extractIATA(originAirport),
      "Destino": extractIATA(destinationAirport),
      "Tipo": tipo,
    };

    return ticketData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          constraints: BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [SizedBox(height: 20), _buildForm()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        child: Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDropdownRow(),
              SizedBox(height: 30),
              _buildInputFields(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: CountPeople()),
        const Expanded(child: DropdownWidgetCompanies()),
        Expanded(child: RadioTypeTicket()),
      ],
    );
  }

  Widget _buildInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: AirportDropdown()),
        Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: () {
              _sendTicketData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              'Procurar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
