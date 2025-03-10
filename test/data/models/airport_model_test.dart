import 'package:flutter_test/flutter_test.dart';
import 'package:passagem_express/data/models/airport_model.dart';

void main() {
  group('Airport Model', () {
    test('should create an Airport object from JSON correctly', () {
      final Map<String, dynamic> json = {
        'Iata': 'BHZ',
        'Nome': 'Belo Horizonte / Todos os Aeroportos',
        'Continente': 'América do Sul',
        'Pais': 'Brasil',
        'PaisCodigo': 'BR',
        'Regiao': 'Minas Gerais',
        'RegiaoCodigo': 'MG',
        'Local': 'Belo Horizonte',
        'SubLocal': null,
        'FusoHorario': 'UTC+10:00',
      };

      final airport = Airport.fromJson(json);

      expect(airport.iata, 'BHZ');
      expect(airport.name, 'Belo Horizonte / Todos os Aeroportos');
      expect(airport.country, 'Brasil');
      expect(airport.countryCode, 'BR');
      expect(airport.region, 'Minas Gerais');
      expect(airport.regionCode, 'MG');
      expect(airport.continent, 'América do Sul');
      expect(airport.location, 'Belo Horizonte');
      expect(airport.subLocation, null);
      expect(airport.timeZone, 'UTC+10:00');
    });
  });
}
