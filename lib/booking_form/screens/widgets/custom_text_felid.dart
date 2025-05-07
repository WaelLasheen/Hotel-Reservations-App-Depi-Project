import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final String initialValue;
  final Function(String) onChange;

  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType,
    required this.onChange,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: TextStyleManager.blackSemiBold15,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyleManager.greyRegular14,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorsManager.grey300),
              ),
              filled: true,
              fillColor: ColorsManager.blue4,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onChanged: (value) {
              onChange(value);
            },
            initialValue: initialValue,
          ),
        ],
      ),
    );
  }
}
