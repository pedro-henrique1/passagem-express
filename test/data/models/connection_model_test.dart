import 'package:flutter_test/flutter_test.dart';
import 'package:passagem_express/data/models/connection_model.dart';

void main() {
  group('Conexao Model', () {
    test('should create a Conexao object from JSON correctly', () {
      final Map<String, dynamic> json = {
        'NumeroVoo': 'AD 9080',
        'EmbarqueCompleto': '3/12/2022 01:55',
        'DesembarqueCompleto': '3/12/2022 04:50',
        'DataEmbarque': '3/12/2022',
        'DataDesembarque': '3/12/2022',
        'Embarque': '01:55',
        'Desembarque': '04:50',
        'Origem': 'GRU',
        'Destino': 'ZZT',
        'Duracao': '02:55',
      };

      final conexao = Connection.fromJson(json);

      expect(conexao.numeroVoo, 'AD 9080');
      expect(conexao.embarqueCompleto, '3/12/2022 01:55');
      expect(conexao.desembarqueCompleto, '3/12/2022 04:50');
      expect(conexao.dataEmbarque, '3/12/2022');
      expect(conexao.dataDesembarque, '3/12/2022');
      expect(conexao.embarque, '01:55');
      expect(conexao.desembarque, '04:50');
      expect(conexao.origem, 'GRU');
      expect(conexao.destino, 'ZZT');
      expect(conexao.duracao, '02:55');
    });

    test('should handle missing values gracefully', () {
      final Map<String, dynamic> json = {
        'NumeroVoo': 'AD 9080',
        'EmbarqueCompleto': '3/12/2022 01:55',
        'DesembarqueCompleto': '3/12/2022 04:50',
        'DataEmbarque': '3/12/2022',
        'DataDesembarque': '3/12/2022',
        'Embarque': '01:55',
        'Desembarque': '04:50',
        'Origem': 'GRU',
        'Destino': 'ZZT',
        'Duracao': '02:55',
      };

      final conexao = Connection.fromJson(json);

      expect(conexao.numeroVoo, 'AD 9080');
      expect(conexao.embarqueCompleto, '3/12/2022 01:55');
      expect(conexao.desembarqueCompleto, '3/12/2022 04:50');
      expect(
        conexao.dataEmbarque,
        '3/12/2022',
      ); // Default empty string as it's not provided
      expect(
        conexao.dataDesembarque,
        '3/12/2022',
      ); // Default empty string as it's not provided
      expect(
        conexao.embarque,
        '01:55',
      ); // Default empty string as it's not provided
      expect(
        conexao.desembarque,
        '04:50',
      ); // Default empty string as it's not provided
      expect(
        conexao.origem,
        'GRU',
      ); // Default empty string as it's not provided
      expect(
        conexao.destino,
        'ZZT',
      ); // Default empty string as it's not provided
      expect(
        conexao.duracao,
        '02:55',
      ); // Default empty string as it's not provided
    });
  });
}
