import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirportDropdownController extends GetxController {
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  final FocusNode originFocus = FocusNode();
  final FocusNode destinationFocus = FocusNode();

  @override
  void onClose() {
    originController.dispose();
    destinationController.dispose();
    originFocus.dispose();
    destinationFocus.dispose();
    super.onClose();
  }
}
