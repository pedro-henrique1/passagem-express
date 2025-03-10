import 'package:passagem_express/data/models/flight_baggage_model.dart';

class MileageDetails {

  MileageDetails({
    required this.adulto,
    required this.crianca,
    required this.bebe,
    required this.executivo,
    required this.taxaEmbarque,
    required this.limiteBagagem,
    required this.tipoMilhas,
  });

  factory MileageDetails.fromJson(Map<String, dynamic> json) {
    return MileageDetails(
      adulto: json['Adulto'],
      crianca: json['Crianca'],
      bebe: json['Bebe'],
      executivo: json['Executivo'],
      taxaEmbarque: json['TaxaEmbarque'],
      limiteBagagem: FlightBaggage.fromJson(json['LimiteBagagem']),
      tipoMilhas: json['TipoMilhas'],
    );
  }
  final num adulto;
  final num crianca;
  final num bebe;
  final bool executivo;
  final double taxaEmbarque;
  final FlightBaggage limiteBagagem;
  final String tipoMilhas;
}
