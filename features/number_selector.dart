import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_icon_button.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';

class NumberSelector extends StatelessWidget {
  final String title;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const NumberSelector({
    super.key,
    required this.title,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleManager.blackSemiBold15,
        ),
        const SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: ColorsManager.grey300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                icon: Icons.remove,
                onPressed: onDecrement,
              ),
              Text(
                value.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              CustomIconButton(
                icon: Icons.add,
                onPressed: onIncrement,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
