class Flight {

  Flight({
    required this.companhia,
    required this.origem,
    required this.destino,
    required this.dataIda,
    required this.dataVolta,
    required this.tipo,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      companhia: json['companhia'],
      origem: json['origem'],
      destino: json['destino'],
      dataIda: json['dataIda'],
      dataVolta: json['dataVolta'],
      tipo: json['tipo'],
    );
  }
  final String companhia;
  final String origem;
  final String destino;
  final String dataIda;
  final String dataVolta;
  final String tipo;

  String? validate() {
    if (companhia.isEmpty) {
      return 'Companhias não podem estar vazias';
    }
    if (origem.isEmpty) {
      return 'Origem não pode ser vazia';
    }
    if (destino.isEmpty) {
      return 'Destino não pode ser vazio';
    }
    if (tipo.isEmpty) {
      return 'Tipo não pode ser vazio';
    }
    if (dataIda.isEmpty) {
      return 'Data de ida não pode ser vazia';
    }
    if (tipo == 'Ida e Volta' && dataVolta.isEmpty) {
      return 'Data de volta não pode ser vazia para tipo Ida e Volta';
    }
    return null;
  }
}
