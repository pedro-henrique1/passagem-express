import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../controller/ticket_type_controller.dart';

class RadioTypeTicket extends StatelessWidget {
  final TicketTypeController controller = Get.put(TicketTypeController());

  RadioTypeTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 15,
        children: <Widget>[
          _buildRadioOption('Somente Ida', SingingCharacter.Ida),
          _buildRadioOption('Ida e Volta', SingingCharacter.IdaVolta),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String text, SingingCharacter value) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.updateTicketType(value);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<SingingCharacter>(
                value: value,
                groupValue: controller.selectedTicketType.value,
                activeColor: Colors.black,
                onChanged: (SingingCharacter? newValue) {
                  if (newValue != null) {
                    controller.updateTicketType(newValue);
                  }
                },
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
