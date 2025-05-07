import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';

class CheckCard extends StatelessWidget {
  final String title;
  final String date;
  final CrossAxisAlignment crossAxisAlignment;

  const CheckCard({
    super.key,
    required this.title,
    required this.date,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(title, style: TextStyleManager.blackSemiBold15),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
            color: ColorsManager.blue4,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: TextStyleManager.greyRegular14),
              const SizedBox(width: 8),
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: ColorsManager.grey600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
