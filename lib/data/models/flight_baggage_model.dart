class FlightBaggage {
  final Map<String, int> bagagemMao;
  final Map<String, int> bagagemDespachada;

  FlightBaggage({required this.bagagemMao, required this.bagagemDespachada});

  factory FlightBaggage.fromJson(Map<String, dynamic> json) {
    return FlightBaggage(
      bagagemMao: Map<String, int>.from(json["BagagemMao"]),
      bagagemDespachada: Map<String, int>.from(json["BagagemDespachada"]),
    );
  }
}
