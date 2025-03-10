// /test/core/models/flight_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:passagem_express/data/models/flight_model.dart';

void main() {
  group('Flight Model', () {
    test('should create a Flight object from JSON correctly', () {
      final Map<String, dynamic> json = {
        'companhia': 'Latam',
        'origem': 'GRU',
        'destino': 'ZZT',
        'dataIda': '3/12/2022',
        'dataVolta': '3/12/2022',
        'tipo': 'Ida e Volta'
      };

      final flight = Flight.fromJson(json);

      expect(flight.companhia, 'Latam');
      expect(flight.origem, 'GRU');
      expect(flight.destino, 'ZZT');
      expect(flight.dataIda, '3/12/2022');
      expect(flight.dataVolta, '3/12/2022');
      expect(flight.tipo, 'Ida e Volta');
    });

    test('should return null when all fields are valid', () {
      final Map<String, dynamic> json = {
        'companhia': 'Latam',
        'origem': 'GRU',
        'destino': 'ZZT',
        'dataIda': '3/12/2022',
        'dataVolta': '3/12/2022',
        'tipo': 'Ida e Volta'
      };

      final flight = Flight.fromJson(json);

      expect(flight.validate(), isNull);
    });

    test('should return error message if companhia is empty', () {
      final Map<String, dynamic> json = {
        'companhia': '',
        'origem': 'GRU',
        'destino': 'ZZT',
        'dataIda': '3/12/2022',
        'dataVolta': '3/12/2022',
        'tipo': 'Ida e Volta'
      };

      final flight = Flight.fromJson(json);

      expect(flight.validate(), equals('Companhias não podem estar vazias'));
    });

    test('should return error message if origem is empty', () {
      final Map<String, dynamic> json = {
        'companhia': 'Latam',
        'origem': '',
        'destino': 'ZZT',
        'dataIda': '3/12/2022',
        'dataVolta': '3/12/2022',
        'tipo': 'Ida e Volta'
      };

      final flight = Flight.fromJson(json);

      expect(flight.validate(), equals('Origem não pode ser vazia'));
    });

    test('should return error message if destino is empty', () {
      final Map<String, dynamic> json = {
        'companhia': 'Latam',
        'origem': 'GRU',
        'destino': '',
        'dataIda': '3/12/2022',
        'dataVolta': '3/12/2022',
        'tipo': 'Ida e Volta'
      };

      final flight = Flight.fromJson(json);

      expect(flight.validate(), equals('Destino não pode ser vazio'));
    });

    test('should return error message if tipo is empty', () {
      final Map<String, dynamic> json = {
        'companhia': 'Latam',
        'origem': 'GRU',
        'destino': 'ZZT',
        'dataIda': '3/12/2022',
        'dataVolta': '3/12/2022',
        'tipo': ''
      };

      final flight = Flight.fromJson(json);

      expect(flight.validate(), equals('Tipo não pode ser vazio'));
    });

    test('should return error message if dataIda is null', () {
      final Map<String, dynamic> json = {
        'companhia': 'Latam',
        'origem': 'GRU',
        'destino': 'ZZT',
        'dataIda': '',  // Em branco
        'dataVolta': '3/12/2022',
        'tipo': 'Ida e Volta'
      };

      final flight = Flight.fromJson(json);

      expect(flight.validate(), equals('Data de ida não pode ser vazia'));
    });

    test('should return error message if dataVolta is null for "Ida e Volta" type', () {
      final Map<String, dynamic> json = {
        'companhia': 'Latam',
        'origem': 'GRU',
        'destino': 'ZZT',
        'dataIda': '3/12/2022',
        'dataVolta': '',  // Em branco
        'tipo': 'Ida e Volta'
      };

      final flight = Flight.fromJson(json);

      expect(flight.validate(), equals('Data de volta não pode ser vazia para tipo Ida e Volta'));
    });
  });
}