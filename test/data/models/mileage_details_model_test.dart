import 'package:flutter_test/flutter_test.dart';
import 'package:passagem_express/data/models/mileage_details_model.dart';

void main() {
  group('MileageDetails', () {
    test('should correctly parse list of MileageDetails from JSON', () {
      final json = {
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
        ]
      };

      final milhasList = (json['Milhas'] as List)
          .map((item) => MileageDetails.fromJson(item))
          .toList();

      final mileageDetails = milhasList[0];

      expect(mileageDetails.adulto, 0);
      expect(mileageDetails.crianca, 0);
      expect(mileageDetails.bebe, 0);
      expect(mileageDetails.executivo, false);
      expect(mileageDetails.taxaEmbarque, 50.23);
      expect(mileageDetails.tipoMilhas, 'Econômico');

      expect(mileageDetails.limiteBagagem.bagagemMao['10kg'], 1);
      expect(mileageDetails.limiteBagagem.bagagemDespachada['23kg'], 1);
      expect(mileageDetails.limiteBagagem.bagagemDespachada['32kg'], 1);
    });
  });
}
