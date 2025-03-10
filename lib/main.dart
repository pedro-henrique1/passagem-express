import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:passagem_express/presentation/controller/airport_controller.dart';
import 'package:passagem_express/presentation/controller/airport_dropdown_controller.dart';
import 'package:passagem_express/presentation/controller/calendar_controller.dart';
import 'package:passagem_express/presentation/controller/ticket_type_controller.dart';
import 'package:passagem_express/presentation/controller/viajantes_controller.dart';
import 'package:passagem_express/presentation/screens/home_screen.dart';
import 'package:passagem_express/presentation/widgets/drop_down_companies.dart';
import 'package:passagem_express/services/airport_service.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ViajantesController());
  Get.put(CalendarController());
  Get.put(TicketTypeController());
  Get.put(AirportController());
  Get.put(AirportDropdownController());
  Get.put(DropdownController());
  Get.put(AirportService());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => HomeScreen())],
    ),
  );
}
