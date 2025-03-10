import 'package:get/get.dart';

class ViajantesController extends GetxController {
  var adultos = 1.obs;
  var criancas = 0.obs;
  var bebes = 0.obs;

  var dadosViajantes = <String, int>{}.obs;

  int get totalViajantes => adultos.value + criancas.value + bebes.value;

  void incrementar(String tipo) {
    if (tipo == 'Adultos') adultos.value++;
    if (tipo == 'Crianças') criancas.value++;
    if (tipo == 'Bebês' && bebes.value < adultos.value) bebes.value++;
  }

  void decrementar(String tipo) {
    if (tipo == 'Adultos' && adultos.value > 1) adultos.value--;
    if (tipo == 'Crianças' && criancas.value > 0) criancas.value--;
    if (tipo == 'Bebês' && bebes.value > 0) bebes.value--;
  }

  void confirmarSelecao(int adultos, int criancas, int bebes) {
    dadosViajantes.assignAll({
      'Adultos': adultos,
      'Crianças': criancas,
      'Bebês': bebes,
    });
  }

}
