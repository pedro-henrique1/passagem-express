// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
//
// class VooCard extends StatelessWidget {
//   final NumberFormat formatador = NumberFormat.currency(
//     locale: 'pt_BR',
//     symbol: 'R\$',
//   );
//
//   final Voo voo;
//   final int adultos;
//   final int criancas;
//   final ValueChanged<int> onItinerarioToggle;
//   final bool isExpanded;
//
//   VooCard({
//     required this.voo,
//     required this.adultos,
//     required this.criancas,
//     required this.onItinerarioToggle,
//     required this.isExpanded,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var valor = voo.valores.first;
//     var bagagemMao = valor.limiteBagagem.bagagemMao;
//     var bagagemDespacahda = valor.limiteBagagem.bagagemDespachada;
//
//     int total = ((valor.adulto * adultos) +
//         (valor.crianca * criancas) +
//         (valor.taxaEmbarque * (adultos + criancas))).toInt();
//
//     return Card(
//       elevation: 6,
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: <Widget>[
//             _buildVooInfoRow(voo),
//             _buildTotalPriceRow(total, context),
//             _buildFlightDetailsRow(voo, valor),
//             _cardItinerario(
//               voo,
//               valor,
//               total,
//               adultos,
//               bagagemMao,
//               bagagemDespacahda,
//               onItinerarioToggle,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Extracted method for building flight info
//   Row _buildVooInfoRow(Voo voo) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         _buildVooInfoColumn(voo.embarque, voo.origem),
//         _buildFlightIcons(),
//         _buildVooInfoColumn(voo.desembarque, voo.destino),
//       ],
//     );
//   }
//
//   Column _buildVooInfoColumn(String time, String location) {
//     return Column(
//       children: <Widget>[
//         Text(
//           formatTime(time),
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
//         ),
//         Text(
//           location,
//           style: GoogleFonts.arimo(
//             fontWeight: FontWeight.w300,
//             fontSize: 14,
//             color: Color.fromRGBO(96, 96, 96, 1),
//             height: 16 / 12,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Row _buildFlightIcons() {
//     return Row(
//       children: [
//         const Icon(Icons.flight_takeoff),
//         SizedBox(width: 40),
//         Expanded(
//           child: Divider(color: Colors.blueAccent.shade400, thickness: 2),
//         ),
//         SizedBox(width: 40),
//         const Icon(Icons.flight_land),
//       ],
//     );
//   }
//
//   Row _buildTotalPriceRow(int total, BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           "Preço total\n ${formatador.format(total)}",
//           style: GoogleFonts.arimo(
//             fontWeight: FontWeight.w100,
//             fontSize: 20,
//             color: Color.fromRGBO(96, 96, 96, 1),
//             height: 1.2,
//           ),
//         ),
//         SizedBox(width: 20),
//         Container(
//           width: MediaQuery.of(context).size.width * 0.10,
//           height: 50,
//           decoration: BoxDecoration(
//             color: Colors.blue.shade700,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: ElevatedButton(
//             onPressed: () => onItinerarioToggle(voo.id),
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.blue,
//               backgroundColor: Colors.white,
//               side: BorderSide(color: Colors.blue, width: 2),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             ),
//             child: const Text(
//               'Itinerario',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Row _buildFlightDetailsRow(Voo voo, Valor valor) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Text(
//           "Duração: ${formatarDuracao(voo.duracao)}",
//           style: GoogleFonts.arimo(
//             fontWeight: FontWeight.w300,
//             fontSize: 16,
//             height: 16 / 12,
//           ),
//         ),
//         Text(
//           "Conexões: ${voo.conexoes.length}",
//           style: GoogleFonts.arimo(
//             fontWeight: FontWeight.w300,
//             fontSize: 16,
//             height: 16 / 12,
//           ),
//         ),
//         Text(
//           "Taxa de embarque: ${formatador.format(valor.taxaEmbarque * (adultos + criancas))}",
//           style: GoogleFonts.arimo(
//             fontWeight: FontWeight.w300,
//             fontSize: 16,
//             height: 16 / 12,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Iteration and display of itinerary details
//   Widget _cardItinerario(
//       Voo voo,
//       Valor valor,
//       int total,
//       int adultos,
//       var bagagemMao,
//       var bagagemDespacahda,
//       ValueChanged<int> onItinerarioToggle,
//       ) {
//     return isExpanded
//         ? Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Itinerário Completo: 🗺️",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//         _buildPriceDetails(valor, total),
//         _buildBaggageDetails(bagagemMao, bagagemDespacahda),
//         _buildConnectionDetails(voo),
//       ],
//     )
//         : Container();
//   }
//
//   // Price breakdown widget
//   Widget _buildPriceDetails(Valor valor, int total) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Detalhamento do Preço: 💵", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         Text("Preço por Passageiro: ${formatador.format(total)}"),
//         Text("Preço por Grupo (2 passageiros): ${formatador.format(valor.adulto * 2)}"),
//         Text("Total: ${formatador.format(total)}"),
//       ],
//     );
//   }
//
//   // Baggage details widget
//   Widget _buildBaggageDetails(var bagagemMao, var bagagemDespacahda) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Bagagens Inclusas: 🧳", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         Text("Bagagem de mão:"),
//         for (var entry in bagagemMao.entries) Text("${entry.key}: ${entry.value} kg"),
//         SizedBox(height: 8),
//         Text("Bagagem despachada:"),
//         for (var entry in bagagemDespacahda.entries) Text("${entry.key}: ${entry.value} kg"),
//       ],
//     );
//   }
//
//   // Flight connection details widget
//   Widget _buildConnectionDetails(Voo voo) {
//     return Column(
//       children: [
//         for (var connection in voo.conexoes) ...[
//           Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("${connection.origem} -> ${connection.destino}"),
//                   Text("Nº Voo: ${connection.numeroVoo}"),
//                   Text("Embarque: ${connection.embarque} (${connection.dataEmbarque})"),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 8),
//         ]
//       ],
//     );
//   }
//
//   String formatTime(String dateTimeString) {
//     try {
//       var dateTime = DateFormat("dd/MM/yyyy HH:mm").parse(dateTimeString);
//       return DateFormat("HH:mm").format(dateTime);
//     } catch (e) {
//       debugPrint("Erro ao formatar a data/hora: $e");
//       return "N/A";
//     }
//   }
//
//   String formatarDuracao(String duracao) {
//     var partes = duracao.split(':');
//     if (partes.length == 2) {
//       return "${partes[0]}h ${partes[1]}m";
//     }
//     return duracao;
//   }
// }
//
