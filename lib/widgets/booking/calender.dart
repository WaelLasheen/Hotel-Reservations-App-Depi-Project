import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/booking/calender_provider.dart';

class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Consumer<CalenderProvider>(
      builder: (context, calenderProvider, _) {
        return Container(
          height: 380,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 15,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (calenderProvider.startBookingDate != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Text(
                                'Check-in',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                calenderProvider.startBookingDate != null
                                    ? '${calenderProvider.startBookingDate!.day}/${calenderProvider.startBookingDate!.month}/${calenderProvider.startBookingDate!.year}'
                                    : 'Select',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (calenderProvider.startBookingDate != null)
                      Container(
                        width: 1,
                        height: 40,
                        color: theme.primaryColor.withOpacity(0.3),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Text(
                              'Check-out',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              calenderProvider.endBookingDate != null
                                  ? '${calenderProvider.endBookingDate!.day}/${calenderProvider.endBookingDate!.month}/${calenderProvider.endBookingDate!.year}'
                                  : 'Select',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: theme.primaryColor,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black87,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.primaryColor,
                      ),
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    onDateChanged: (date) {
                      calenderProvider.setBookingDate(date);
                    },
                  ),
                ),
              ),
              if (calenderProvider.startBookingDate != null && calenderProvider.endBookingDate == null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Select checkout date',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
} 