class Connection {
  final String numeroVoo;
  final String embarqueCompleto;
  final String desembarqueCompleto;
  final String dataEmbarque;
  final String dataDesembarque;
  final String embarque;
  final String desembarque;
  final String origem;
  final String destino;
  final String duracao;

  Connection({
    required this.numeroVoo,
    required this.embarqueCompleto,
    required this.desembarqueCompleto,
    required this.dataEmbarque,
    required this.dataDesembarque,
    required this.embarque,
    required this.desembarque,
    required this.origem,
    required this.destino,
    required this.duracao,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      numeroVoo: json["NumeroVoo"],
      embarqueCompleto: json["EmbarqueCompleto"],
      desembarqueCompleto: json["DesembarqueCompleto"],
      dataEmbarque: json["DataEmbarque"],
      dataDesembarque: json["DataDesembarque"],
      embarque: json["Embarque"],
      desembarque: json["Desembarque"],
      origem: json["Origem"],
      destino: json["Destino"],
      duracao: json["Duracao"],
    );
  }
}
