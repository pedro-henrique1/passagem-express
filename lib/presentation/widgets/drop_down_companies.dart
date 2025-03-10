import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<String> list = <String>[
  'AMERICAN AIRLINES',
  'GOL',
  'IBERIA',
  'INTERLINE',
  'LATAM',
  'AZUL',
  'TAP',
];

class DropdownWidgetCompanies extends StatelessWidget {
  const DropdownWidgetCompanies({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DropdownController>(
      builder: (controller) {
        String displayText;
        if (controller.selectedAirlines.isEmpty) {
          displayText = 'Selecione as companhias';
        } else {
          var selectedList = controller.selectedAirlines.toList();
          displayText =
              selectedList.length <= 3
                  ? selectedList.join(', ')
                  : '${selectedList.take(3).join(', ')} e mais';
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                _showSelectionDialog(context, controller);
              },
              child: DropdownButtonFormField<String>(
                value: null,
                hint: Text(
                  displayText,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onChanged: (value) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.blue.shade200,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
                items: const [],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSelectionDialog(
    BuildContext context,
    DropdownController controller,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione as Companhias'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...list.map((entry) {
                return Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.selectedAirlines.contains(entry),
                        onChanged: (bool? selected) {
                          controller.toggleSelection(entry, selected!);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      entry,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Confirmar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DropdownController extends GetxController {
  var selectedAirlines = <String>[].obs;

  void toggleSelection(String airline, bool isSelected) {
    if (isSelected) {
      if (selectedAirlines.length < 7) {
        selectedAirlines.add(airline);
      }
    } else {
      selectedAirlines.remove(airline);
    }
  }
}
