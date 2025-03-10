import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passagem_express/data/models/airport_model.dart';
import 'package:passagem_express/data/models/ticket_model.dart';

class AirportRepository {
  AirportRepository({Dio? dio}) : _dio = dio ?? Dio();
  final Dio _dio;

  final String? _baseUrl = dotenv.env['BUSCA_MILHAS_URL'];

  Future<List<Airport>> getAirports(String query) async {
    try {
      final response = await _dio.get('$_baseUrl/aeroportos?q=$query');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Airport.fromJson(json)).toList();
      } else {
        throw Exception(
          'Erro ao buscar aeroportos: Status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao buscar aeroportos: $e');
    }
  }

  Future<String> createTicket(Map<String, dynamic> requestData) async {
    String jsonString = jsonEncode(requestData);
    try {
      final response = await _dio.post(
        '$_baseUrl/busca/criar',
        data: jsonString,
      );
      String buscaId = response.data['Busca'];
      return buscaId;
    } catch (e) {
      throw Exception('Erro ao criar ticket: $e');
    }
  }

  Future<List<TicketModel>> searchFlights(String id) async {
    try {
      final response = await _dio.get('$_baseUrl/busca/$id');

      List<dynamic> data = response.data['Voos'];
      return data.map((json) => TicketModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar voos: $e');
    }
  }
}
