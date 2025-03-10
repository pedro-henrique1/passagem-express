import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:passagem_express/data/models/ticket_model.dart';

import '../controller/viajantes_controller.dart';

class FlightOfferList extends StatefulWidget {
  final String ticketId;
  final List<TicketModel> flights;
  final Function(TicketModel) onTicketSelected;
  final bool Function(TicketModel) isSelected;
  final bool showOnlySelected;

  const FlightOfferList({
    super.key,
    required this.ticketId,
    required this.flights,
    required this.onTicketSelected,
    required this.isSelected,
    required this.showOnlySelected,
  });

  @override
  _FlightOfferListState createState() => _FlightOfferListState();
}

class _FlightOfferListState extends State<FlightOfferList> {
  final NumberFormat formatador = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  final viajantesController = Get.find<ViajantesController>();
  late List<bool> isExpandedList;

  @override
  void initState() {
    super.initState();
    isExpandedList = List.generate(widget.flights.length, (index) => false);
  }


  @override
  void didUpdateWidget(FlightOfferList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Atualiza a lista apenas se o número de voos mudar
    if (widget.flights.length != oldWidget.flights.length) {
      setState(() {
        isExpandedList = List.generate(widget.flights.length, (index) => false);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    int adultos = viajantesController.dadosViajantes['Adultos'] ?? 1;
    int criancas = viajantesController.dadosViajantes['Crianças'] ?? 0;
    int bebes = viajantesController.dadosViajantes['Bebês'] ?? 0;

    final flightsToShow =
        widget.showOnlySelected
            ? [widget.flights.firstWhere(widget.isSelected)]
            : widget.flights;
    return ListView.builder(
      itemCount: flightsToShow.length,
      itemBuilder: (context, index) {
        final flight = widget.flights[index];
        var valor = flight.valores.first;
        var bagagemMao = flight.valores.first.limiteBagagem.bagagemMao;
        var bagagemDespacahda =
            flight.valores.first.limiteBagagem.bagagemDespachada;

        int total =
            ((valor.adulto * adultos) +
                    (valor.crianca * criancas) +
                    (valor.taxaEmbarque * (adultos + criancas)))
                .toInt();
        bool isSelected = widget.isSelected(flight);
        print(isSelected);
        return GestureDetector(
          onTap: (){
            widget.onTicketSelected(flight);
          },
          child: Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: isSelected ? Colors.blue.shade100 : Colors.white, // Cor de fundo
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          formatTime(flight.embarque),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          flight.origem,
                          style: GoogleFonts.arimo(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Color.fromRGBO(96, 96, 96, 1),
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    const Icon(Icons.flight_takeoff),
                    SizedBox(width: 40),
                    Expanded(
                      child: Divider(
                        color: Colors.blueAccent.shade400,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(width: 40),
                    const Icon(Icons.flight_land),
                    SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatTime(flight.desembarque),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          flight.destino,
                          style: GoogleFonts.arimo(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Color.fromRGBO(96, 96, 96, 1),
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Preço total\n ${formatador.format(total)}",
                            style: GoogleFonts.arimo(
                              fontWeight: FontWeight.w100,
                              fontSize: 20,
                              color: Color.fromRGBO(96, 96, 96, 1),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 50, width: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (index >= 0 && index < isExpandedList.length) {
                                  setState(() {
                                    isExpandedList[index] = !isExpandedList[index]; // Alterna o estado
                                  });
                                }
                              },

                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.blue, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Itinerario',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Duração: ${formatarDuracao(flight.duracao)}",
                      style: GoogleFonts.arimo(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 16 / 12,
                      ),
                    ),
                    Text(
                      "Conexões: ${flight.conexoes.length}",
                      style: GoogleFonts.arimo(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 16 / 12,
                      ),
                    ),
                    Text(
                      "Taxa de embarque: ${formatador.format(valor.taxaEmbarque * (adultos + criancas))}",
                      style: GoogleFonts.arimo(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 16 / 12,
                      ),
                    ),
                  ],
                ),
                _cardItinerario(
                  index,
                  flight,
                  valor,
                  total,
                  adultos,
                  bagagemMao,
                  bagagemDespacahda,
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  Widget _cardItinerario(
    int index,
    flight,
    valor,
    total,
    adulto,
    bagagemMao,
    bagagemDespacahda,
  ) {
    return Row(
      children: [
        Expanded(
          child:
              isExpandedList[index]
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Itinerário Completo: 🗺️",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Detalhamento do Preço: 💵",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Preço por Passageiro: ${formatador.format(total)}",
                              ),
                              Text(
                                "Preço por Grupo (2 passageiros): ${formatador.format(valor.adulto * 2)}",
                              ),
                              Text("Total: ${formatador.format(total)}"),
                            ],
                          ),
                          SizedBox(width: 16), // Espaço entre as colunas
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Text(
                                "Bagagens Inclusas: 🧳",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text("Bagagem de mão:"),
                              for (var entry in bagagemMao.entries)
                                Text("${entry.key}: ${entry.value} kg"),
                              SizedBox(height: 8),
                              Text("Bagagem despachada:"),
                              for (var entry in bagagemDespacahda.entries)
                                Text("${entry.key}: ${entry.value} kg"),
                            ],
                          ),
                        ],
                      ),
                      for (var i = 0; i < flight.conexoes.length; i++) ...[
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${flight.conexoes[i].origem} -> ${flight.conexoes[i].destino}",
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nº Voo: ${flight.conexoes[i].numeroVoo}",
                                    ),
                                    Text(
                                      "Duração: ${flight.conexoes[i].duracao}",
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Embarque: ${flight.conexoes[i].embarque} (${flight.conexoes[i].dataEmbarque})",
                                    ),
                                    Text(
                                      "Desembarque: ${flight.conexoes[i].desembarque} (${flight.conexoes[i].dataDesembarque})",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ],
                  )
                  : Container(),
        ),
      ],
    );
  }
}

String formatTime(String dateTimeString) {
  try {
    var dateTime = DateFormat("dd/MM/yyyy HH:mm").parse(dateTimeString);
    return DateFormat("HH:mm").format(dateTime);
  } catch (e) {
    debugPrint("Erro ao formatar a data/hora: $e");
    return "N/A";
  }
}

String formatarDuracao(String duracao) {
  List<String> partes = duracao.split(":");
  int horas = int.parse(partes[0]);
  int minutos = int.parse(partes[1]);

  return "${horas}h ${minutos}m";
}
