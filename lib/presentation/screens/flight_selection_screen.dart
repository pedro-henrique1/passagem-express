import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passagem_express/data/models/ticket_model.dart';
import 'package:passagem_express/presentation/widgets/flight_offer_list.dart';
import 'package:passagem_express/services/airport_service.dart';

class FlightSelectionScreen extends StatefulWidget {

  const FlightSelectionScreen({super.key, required this.ticketId});
  final String ticketId;

  @override
  _FlightSelectionScreen createState() => _FlightSelectionScreen();
}

class _FlightSelectionScreen extends State<FlightSelectionScreen> {
  final NumberFormat formatador = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  late List<TicketModel> idaFlights;
  late List<TicketModel> voltaFlights;

  TicketModel? selectedDeparture;
  TicketModel? selectedReturn;

  @override
  void initState() {
    super.initState();
    idaFlights = [];
    voltaFlights = [];
    _loadFlights();
  }

  void _loadFlights() async {
    final _ticketService = Get.put(AirportService());
    final tickets = await _ticketService.searchTickets(
      widget.ticketId,
    );

    setState(() {
      idaFlights = tickets.where((ticket) => ticket.sentido == 'Ida').toList();
      voltaFlights =
          tickets.where((ticket) => ticket.sentido == 'Volta').toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            text: "Escolha um ",
            children: [
              TextSpan(
                text: "voo de ida",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FlightOfferList(
                ticketId: widget.ticketId,
                flights: idaFlights,
                onTicketSelected: (ticket) {
                  setState(() {
                    selectedDeparture = ticket;
                    idaFlights = [ticket];
                  });
                },
                isSelected: (flight) => selectedDeparture == flight,
                showOnlySelected: selectedDeparture != null,
              ),

            ),
            Visibility(
              visible: selectedDeparture != null && voltaFlights.isNotEmpty && selectedReturn == null,
              child: const Text.rich(
                TextSpan(
                  text: "Escolha um ",
                  style: TextStyle(fontSize: 20),
                  children: [
                    TextSpan(
                      text: "voo de volta",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            if (selectedDeparture != null && voltaFlights.isNotEmpty)
            // Text("Voo de ida selecionado"),
              Expanded(
                child: FlightOfferList(
                  ticketId: widget.ticketId,
                  flights: voltaFlights,
                  onTicketSelected: (ticket) {
                    setState(() {
                      selectedReturn = ticket;
                      voltaFlights = [ticket];
                    });
                  },
                  isSelected: (flight) => selectedReturn == flight,
                  showOnlySelected: selectedReturn != null,
                ),
              ),
            if (selectedDeparture != null && selectedReturn != null)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Passagens de ida e volta selecionado",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            if (selectedDeparture != null && selectedReturn == null)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Passagem de ida selecionada",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
