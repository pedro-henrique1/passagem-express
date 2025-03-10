import 'package:passagem_express/data/models/flight_baggage_model.dart';

class FlightValue {
  final double adulto;
  final double crianca;
  final double bebe;
  final bool executivo;
  final double taxaEmbarque;
  final FlightBaggage limiteBagagem;
  final String tipoValor;

  FlightValue({
    required this.adulto,
    required this.crianca,
    required this.bebe,
    required this.executivo,
    required this.taxaEmbarque,
    required this.limiteBagagem,
    required this.tipoValor,
  });

  factory FlightValue.fromJson(Map<String, dynamic> json) {
    return FlightValue(
      adulto: json["Adulto"],
      crianca: json["Crianca"],
      bebe: json["Bebe"],
      executivo: json["Executivo"],
      taxaEmbarque: json["TaxaEmbarque"],
      limiteBagagem: FlightBaggage.fromJson(json["LimiteBagagem"]),
      tipoValor: json["TipoValor"],
    );
  }
}
