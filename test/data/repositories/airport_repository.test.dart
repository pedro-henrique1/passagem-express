import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:passagem_express/data/models/airport_model.dart';
import 'package:passagem_express/data/models/ticket_model.dart';
import 'package:passagem_express/data/repositories/airport_repository.dart';

// Criando um Mock para o Dio
class MockDio extends Mock implements Dio {}

Future<void> main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  group('AirportRepository', () {
    late MockDio mockDio;
    late AirportRepository repository;

    setUp(()  {
      mockDio = MockDio();
      repository = AirportRepository(dio: mockDio);
    });

    test('deve retornar uma lista de aeroportos', () async {
      final query = 'GRU';
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
          'Aeroportos': []
        }
      ];

      // Configurando o comportamento do Dio mockado
      when(mockDio.get(
        '${dotenv.env['BUSCA_MILHAS_URL']}/aeroportos?q=$query',
      ),).thenAnswer((_) async {
        return Response(
          data: mockResponse, // Dados simulados para a resposta
          statusCode: 200,   // Código de status 200 OK
          requestOptions: RequestOptions(path: ''),
        );
      });

      // Executando o método
      final result = await repository.getAirports(query);

      // Verificando o resultado
      expect(result, isA<List<Airport>>());
      expect(result.length, 1);
      expect(result[0].iata, 'GRU');
    });

    // Teste do método createTicket
    test('deve criar um ticket e retornar o ID', () async {
      final requestData = {
        'origem': 'GRU',
        'destino': 'ZZT',
        'data': '2023-12-15',
      };

      final mockResponse = {'Busca': '12345'};

      // Configurando o comportamento do Dio mockado
      when(mockDio.post('http://localhost:3000/busca/criar', data: jsonEncode(requestData)))
          .thenAnswer((_) async => Response(
        data: mockResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Executando o método
      final result = await repository.createTicket(requestData);

      // Verificando o resultado
      expect(result, '12345');
    });

    // Teste do método searchFlights
    test('deve buscar voos com base no ID e retornar uma lista de tickets', () async {
      final id = '12345';
      final mockResponse = {
        'Voos': [
          {
            'numeroVoo': 'AD 9080',
            'origem': 'GRU',
            'destino': 'ZZT',
            'dataEmbarque': '3/12/2022',
            'dataDesembarque': '3/12/2022',
            'duracao': '02:55',
          }
        ]
      };

      // Configurando o comportamento do Dio mockado
      when(mockDio.get('http://localhost:3000/busca/$id'))
          .thenAnswer((_) async => Response(
        data: mockResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Executando o método
      final result = await repository.searchFlights(id);

      // Verificando o resultado
      expect(result, isA<List<TicketModel>>());
      expect(result.length, 1);
      expect(result[0].numeroVoo, 'AD 9080');
    });
  });
}