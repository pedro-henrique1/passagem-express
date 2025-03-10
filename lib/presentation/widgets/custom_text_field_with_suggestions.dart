import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passagem_express/presentation/controller/airport_controller.dart';

class CustomTextFieldWithOverlay extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData icon;
  final String hint;
  final ValueChanged<String> onChanged;
  final String? Function(String?)?
  validator; // Adicionado parâmetro de validação

  const CustomTextFieldWithOverlay({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.icon,
    required this.hint,
    required this.onChanged,
    this.validator, // Passando a validação
  });

  @override
  _CustomTextFieldWithOverlayState createState() =>
      _CustomTextFieldWithOverlayState();
}

class _CustomTextFieldWithOverlayState
    extends State<CustomTextFieldWithOverlay> {
  final AirportController airportController = Get.find<AirportController>();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final ValueNotifier<bool> _showOverlay = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(() {
      if (!widget.focusNode.hasFocus) {
        _hideOverlay();
      }
    });
  }

  void _showOverlayIfNeeded() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _showOverlay.value = true;
    }
  }

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _showOverlay.value = false;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder:
          (context) => Positioned(
            width: MediaQuery.of(context).size.width * 0.3,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(0, 60),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Obx(() {
                  if (airportController.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (airportController.airports.isNotEmpty) {
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        itemCount: airportController.airports.length,
                        itemBuilder: (context, index) {
                          final airport = airportController.airports[index];
                          return ListTile(
                            title: Text(
                              "${airport.name}, ${airport.iata} - ${airport.country}",
                            ),
                            onTap: () {
                              widget.controller.text =
                                  "${airport.name}, ${airport.iata} - ${airport.country}";
                              airportController.airports.clear();
                              _hideOverlay();
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ),
            ),
          ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    _showOverlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(widget.icon),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      onChanged: (value) {
                        widget.onChanged(value);
                        if (value.isNotEmpty) {
                          _showOverlayIfNeeded();
                        } else {
                          _hideOverlay();
                        }
                      },
                      validator: widget.validator, // Aplica a validação aqui
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        border: InputBorder.none,
                      ),
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
