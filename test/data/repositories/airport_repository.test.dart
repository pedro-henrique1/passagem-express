import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passagem_express/data/models/airport_model.dart';
import 'package:passagem_express/data/repositories/airport_repository.dart';

import 'airport_repository.test.mocks.dart';

@GenerateMocks([Dio], customMocks: [
  MockSpec<Dio>(as: #MockDioCustom),
],)
Future<void> main() async {
  await dotenv.load();

  group('AirportRepository', () {
    late MockDioCustom mockDio;
    late AirportRepository repository;

    setUp(() {
      mockDio = MockDioCustom();
      repository = AirportRepository(dio: mockDio);
    });

    test('deve retornar uma lista de aeroportos', () async {
      const query = 'VCP';
      final mockResponse = [
        {
          'Iata': 'VCP',
          'Nome': 'Campinas / Viracopos',
          'Pais': 'Brasil',
          'PaisCodigo': 'BR',
          'Regiao': 'São Paulo',
          'RegiaoCodigo': 'SP',
          'Continente': 'América do Sul',
          'Local': 'São Paulo / Campinas, São Paulo, Brazil',
          'SubLocal': 'Parque Universitario de Viracopos',
          'FusoHorario': null,
        },
      ];

      when(mockDio.get(
        '${dotenv.env['BUSCA_MILHAS_URL']}/aeroportos?q=$query',
      ),).thenAnswer(
            (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.getAirports(query);

      expect(result, isA<List<Airport>>());
      expect(result.length, 1);
      expect(result[0].iata, 'VCP');
      expect(result[0].name, 'Campinas / Viracopos');
      expect(result[0].subLocation, 'Parque Universitario de Viracopos');
    });

    test('deve retornar uma lista de aeroportos com GRU', () async {
      const query = 'GRU';

      final mockResponse = [
        {
          'Iata': 'GRU',
          'Nome': 'Aeroporto Internacional de São Paulo',
          'Pais': 'Brasil',
          'PaisCodigo': 'BR',
          'Regiao': 'Sudeste',
          'RegiaoCodigo': 'SE',
          'Continente': 'América do Sul',
          'Local': 'São Paulo',
          'SubLocal': null,
          'FusoHorario': 'UTC -3',
          'Aeroportos': [],
        },
      ];

      when(mockDio.get(
        '${dotenv.env['BUSCA_MILHAS_URL']}/aeroportos?q=$query',
      ),).thenAnswer(
            (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.getAirports(query);

      expect(result, isA<List<Airport>>());
      expect(result.length, 1);
      expect(result[0].iata, 'GRU');
    });
  });
}
