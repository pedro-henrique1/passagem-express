// /test/core/models/valor_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:passagem_express/data/models/flight_baggage_model.dart';
import 'package:passagem_express/data/models/flight_value_model.dart';

void main() {
  group('Valor Model', () {
    test('should create a Valor object from JSON correctly', () {
      final Map<String, dynamic> json = {
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
      };

      final valor = FlightValue.fromJson(json);

      expect(valor.adulto, 0);
      expect(valor.crianca, 0);
      expect(valor.bebe, 0);
      expect(valor.executivo, false);
      expect(valor.taxaEmbarque, 50.23);
      expect(valor.limiteBagagem.bagagemMao, {'10kg': 1});
      expect(valor.limiteBagagem.bagagemDespachada, {'23kg': 1, '32kg': 1});
      expect(valor.tipoValor, 'Econômico');
    });

    test('should validate the properties correctly', () {
      final Map<String, dynamic> json = {
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
      };

      final valor = FlightValue.fromJson(json);

      expect(valor.adulto, isA<int>());
      expect(valor.crianca, isA<int>());
      expect(valor.bebe, isA<int>());
      expect(valor.executivo, isA<bool>());
      expect(valor.taxaEmbarque, isA<double>());
      expect(valor.limiteBagagem, isA<FlightBaggage>());
      expect(valor.tipoValor, isA<String>());
    });

    test('should return correct values when the properties are set', () {
      final Map<String, dynamic> json = {
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
      };

      final valor = FlightValue.fromJson(json);

      // Verificação de valores específicos
      expect(valor.adulto, 0);
      expect(valor.crianca, 0);
      expect(valor.bebe, 0);
      expect(valor.executivo, false);
      expect(valor.taxaEmbarque, 50.23);
      expect(valor.limiteBagagem.bagagemMao, {'10kg': 1});
      expect(valor.limiteBagagem.bagagemDespachada, {'23kg': 1, '32kg': 1});
      expect(valor.tipoValor, 'Econômico');
    });
  });
}