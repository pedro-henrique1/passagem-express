import 'package:get/get.dart';
import 'package:passagem_express/data/models/airport_model.dart';
import 'package:passagem_express/services/airport_service.dart';

class AirportController extends GetxController {
  final AirportService _airportService = AirportService();
  var airports = <Airport>[].obs;
  var isLoading = false.obs;

  void searchAirports(String query) async {
    if (query.isEmpty) return;
    isLoading.value = true;
    try {
      airports.value = await _airportService.searchAirports(query);
    } finally {
      isLoading.value = false;
    }
  }
}
