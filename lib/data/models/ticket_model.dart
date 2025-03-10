import 'package:passagem_express/data/models/connection_model.dart';
import 'package:passagem_express/data/models/flight_value_model.dart';
import 'package:passagem_express/data/models/mileage_details_model.dart';

class TicketModel {
  final String companhia;
  final String sentido;
  final String origem;
  final String destino;
  final String embarque;
  final String desembarque;
  final String duracao;
  final String numeroVoo;
  final int numeroConexoes;
  final List<FlightValue> valores;
  final List<MileageDetails> milhas;
  final List<Connection> conexoes;

  TicketModel({
    required this.companhia,
    required this.sentido,
    required this.origem,
    required this.destino,
    required this.embarque,
    required this.desembarque,
    required this.duracao,
    required this.numeroVoo,
    required this.numeroConexoes,
    required this.valores,
    required this.milhas,
    required this.conexoes,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      companhia: json['Companhia'],
      sentido: json['Sentido'],
      origem: json['Origem'],
      destino: json['Destino'],
      embarque: json['Embarque'],
      desembarque: json['Desembarque'],
      duracao: json['Duracao'],
      numeroVoo: json['NumeroVoo'],
      numeroConexoes: json['NumeroConexoes'],
      valores:
          (json['Valor'] as List<dynamic>)
              .map((item) => FlightValue.fromJson(item))
              .toList(),
      milhas:
          (json['Milhas'] as List<dynamic>)
              .map((item) => MileageDetails.fromJson(item))
              .toList(),
      conexoes:
          (json['Conexoes'] as List<dynamic>)
              .map((item) => Connection.fromJson(item))
              .toList(),
    );
  }
}
