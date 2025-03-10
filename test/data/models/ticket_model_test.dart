import 'package:flutter_test/flutter_test.dart';
import 'package:passagem_express/data/models/ticket_model.dart';

void main() {
  group('TicketModel', () {
    test('should correctly parse from JSON', () {
      final json = {
        'Voos': [
          {
            'Companhia': 'AZUL',
            'Sentido': 'Ida',
            'Origem': 'GRU',
            'Destino': 'MIA',
            'Embarque': '3/12/2022 01:55',
            'Desembarque': '3/12/2022 13:10',
            'Duracao': '11:15',
            'NumeroVoo': 'AD 7051',
            'NumeroConexoes': 1,
            'Valor': [
              {
                'Adulto': 0,
                'Crianca': 0,
                'Bebe': 0,
                'Executivo': false,
                'TaxaEmbarque': 50.23,
                'LimiteBagagem': {
                  'BagagemMao': {
                    '10kg': 1
                  },
                  'BagagemDespachada': {
                    '23kg': 1,
                    '32kg': 1
                  }
                },
                'TipoValor': 'Econômico'
              }
            ],
            'Milhas': [
              {
                'Adulto': 0,
                'Crianca': 0,
                'Bebe': 0,
                'Executivo': false,
                'TaxaEmbarque': 50.23,
                'LimiteBagagem': {
                  'BagagemMao': {
                    '10kg': 1
                  },
                  'BagagemDespachada': {
                    '23kg': 1,
                    '32kg': 1
                  }
                },
                'TipoMilhas': 'Econômico'
              }
            ],
            'Conexoes': [
              {
                'NumeroVoo': 'AD 9080',
                'EmbarqueCompleto': '3/12/2022 01:55',
                'DesembarqueCompleto': '3/12/2022 04:50',
                'DataEmbarque': '3/12/2022',
                'DataDesembarque': '3/12/2022',
                'Embarque': '01:55',
                'Desembarque': '04:50',
                'Origem': 'GRU',
                'Destino': 'ZZT',
                'Duracao': '02:55'
              }
            ]
          }
        ]
      };

      final voosList = (json['Voos'] as List)
          .map((item) => TicketModel.fromJson(item))
          .toList();

      final ticket = voosList[0];

      expect(ticket.companhia, 'AZUL');
      expect(ticket.sentido, 'Ida');
      expect(ticket.origem, 'GRU');
      expect(ticket.destino, 'MIA');
      expect(ticket.embarque, '3/12/2022 01:55');
      expect(ticket.desembarque, '3/12/2022 13:10');
      expect(ticket.duracao, '11:15');
      expect(ticket.numeroVoo, 'AD 7051');
      expect(ticket.numeroConexoes, 1);

      final flightValue = ticket.valores[0];
      expect(flightValue.adulto, 0);
      expect(flightValue.crianca, 0);
      expect(flightValue.bebe, 0);
      expect(flightValue.executivo, false);
      expect(flightValue.taxaEmbarque, 50.23);
      expect(flightValue.tipoValor, 'Econômico');

      final mileageDetails = ticket.milhas[0];
      expect(mileageDetails.adulto, 0);
      expect(mileageDetails.crianca, 0);
      expect(mileageDetails.bebe, 0);
      expect(mileageDetails.executivo, false);
      expect(mileageDetails.taxaEmbarque, 50.23);
      expect(mileageDetails.tipoMilhas, 'Econômico');

      final connection = ticket.conexoes[0];
      expect(connection.numeroVoo, 'AD 9080');
      expect(connection.embarqueCompleto, '3/12/2022 01:55');
      expect(connection.desembarqueCompleto, '3/12/2022 04:50');
      expect(connection.dataEmbarque, '3/12/2022');
      expect(connection.dataDesembarque, '3/12/2022');
      expect(connection.embarque, '01:55');
      expect(connection.desembarque, '04:50');
      expect(connection.origem, 'GRU');
      expect(connection.destino, 'ZZT');
      expect(connection.duracao, '02:55');
    });
  });
}
