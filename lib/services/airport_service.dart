import 'package:passagem_express/data/models/airport_model.dart';
import 'package:passagem_express/data/models/ticket_model.dart';
import 'package:passagem_express/data/repositories/airport_repository.dart';

class AirportService {
  final AirportRepository _repository = AirportRepository();

  Future<List<Airport>> searchAirports(String query) async {
    try {
      return await _repository.getAirports(query);
    } catch (e) {
      throw Exception('Erro ao buscar aeroportos: $e');
    }
  }

  Future<String?> createTicket(Map<String, dynamic> query) async {
    try {
      final response = await _repository.createTicket(query);
      return response.isNotEmpty ? response : null;
    } catch (e) {
      throw Exception('Erro ao criar ticket: $e');
    }
  }

  Future<List<TicketModel>> searchTickets(String ticketUuid) async {
    try {
      return await _repository.searchFlights(ticketUuid);
    } catch (e) {
      throw Exception('Erro ao buscar voos: $e');
    }
  }
}
