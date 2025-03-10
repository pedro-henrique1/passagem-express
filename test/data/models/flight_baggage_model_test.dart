import 'package:flutter_test/flutter_test.dart';
import 'package:passagem_express/data/models/flight_baggage_model.dart';

void main() {
  group('LimiteBagagem Model', () {
    test('should create a LimiteBagagem object from JSON correctly', () {
      final Map<String, dynamic> json = {
        'BagagemMao': {'10kg': 1},
        'BagagemDespachada': {'23kg': 1, '32kg': 1},
      };

      final limiteBagagem = FlightBaggage.fromJson(json);

      expect(limiteBagagem.bagagemMao, {'10kg': 1});
      expect(limiteBagagem.bagagemDespachada, {'23kg': 1, '32kg': 1});
    });

    test('should handle empty baggage maps gracefully', () {
      final Map<String, dynamic> json = {
        'BagagemMao': {},
        'BagagemDespachada': {},
      };

      final limiteBagagem = FlightBaggage.fromJson(json);

      expect(limiteBagagem.bagagemMao, {});
      expect(limiteBagagem.bagagemDespachada, {});
    });

    test('should handle missing baggage keys gracefully', () {
      final Map<String, dynamic> json = {
        'BagagemMao': {'10kg': 1},
        'BagagemDespachada': {},
      };

      final limiteBagagem = FlightBaggage.fromJson(json);

      expect(limiteBagagem.bagagemMao, {'10kg': 1});
      expect(
        limiteBagagem.bagagemDespachada,
        {},
      ); // Default to empty map if missing
    });
  });
}
