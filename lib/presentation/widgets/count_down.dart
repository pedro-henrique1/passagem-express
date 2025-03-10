import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/viajantes_controller.dart';

class CountDown extends GetxController {
  var adultos = 1.obs;
  var criancas = 0.obs;
  var bebes = 0.obs;
  var isExpanded = false.obs;

  int get totalViajantes => adultos.value + criancas.value + bebes.value;

  void incrementarAdulto() {
    if (totalViajantes < 9) {
      adultos.value++;
    }
  }

  void decrementarAdulto() {
    if (adultos.value > 1) adultos.value--;
  }

  void incrementarCrianca() {
    if (totalViajantes < 9) {
      criancas.value++;
    }
  }

  void decrementarCrianca() {
    if (criancas.value > 0) criancas.value--;
  }

  void incrementarBebe() {
    if (totalViajantes < 9 && bebes.value < adultos.value) {
      bebes.value++;
    }
  }

  void decrementarBebe() {
    if (bebes.value > 0) bebes.value--;
  }

  void toggleExpand() => isExpanded.value = !isExpanded.value;
}

class CountPeople extends StatefulWidget {
  const CountPeople({super.key});

  @override
  _CountPeopleState createState() => _CountPeopleState();
}

class _CountPeopleState extends State<CountPeople> {
  final controller = CountDown();
  final LayerLink _layerLink = LayerLink();
  final ViajantesController _viajantesController = Get.put(
    ViajantesController(),
  );
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder:
          (context) => Positioned(
            width: 220,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(0, 50),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Obx(() {
                  if (controller.isExpanded.value) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildCounterRow(
                            'Adultos',
                            '12 anos ou mais',
                            controller.adultos,
                            controller.incrementarAdulto,
                            controller.decrementarAdulto,
                          ),
                          _buildCounterRow(
                            'Crianças',
                            'De 2 a 11 anos',
                            controller.criancas,
                            controller.incrementarCrianca,
                            controller.decrementarCrianca,
                          ),
                          _buildCounterRow(
                            'Bebês',
                            'Menores de 2 anos',
                            controller.bebes,
                            controller.incrementarBebe,
                            controller.decrementarBebe,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _viajantesController.confirmarSelecao(
                                  controller.adultos.value,
                                  controller.criancas.value,
                                  controller.bebes.value,
                                ); // Chama o método de confirmação
                                _hideOverlay();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Confirmar'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ),
            ),
          ),
    );
  }

  Widget _buildCounterRow(
    String titulo,
    String subtitulo,
    RxInt valor,
    VoidCallback incrementar,
    VoidCallback decrementar,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitulo,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: decrementar,
                icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
              ),
              Obx(() => Text('${valor.value}', style: TextStyle(fontSize: 16))),
              IconButton(
                onPressed: incrementar,
                icon: Icon(Icons.add_circle_outline, color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.toggleExpand();
              if (controller.isExpanded.value) {
                _showOverlay();
              } else {
                _hideOverlay();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Text(
                      "${controller.totalViajantes} Passageiros",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Obx(
                    () => Icon(
                      controller.isExpanded.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
