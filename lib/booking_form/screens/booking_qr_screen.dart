import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_appbar.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class BookingQRScreen extends StatelessWidget {
  const BookingQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    // Create a map of booking data
    final bookingData = {
      'hotel': bookingProvider.hotel?.name,
      'client': {
        'name': '${bookingProvider.firstName} ${bookingProvider.lastName}',
        'email': bookingProvider.email,
        'phone': bookingProvider.phoneNumber,
      },
      'checkIn': bookingProvider.startDate?.toIso8601String(),
      'checkOut': bookingProvider.endDate?.toIso8601String(),
      'guests': bookingProvider.numberOfGuests,
      'rooms': bookingProvider.numberOfRooms,
      'totalCost': bookingProvider.calculateCost(),
    };

    // Convert to JSON string
    final qrData = jsonEncode(bookingData);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Booking QR Code',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 250.0,
              backgroundColor: ColorsManager.white,
            ),
            const SizedBox(height: 32),
            const Text(
              'Scan this QR code to view your booking details',
              style: TextStyleManager.greyRegular14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Back to Home',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (Route<dynamic> route) => false,
                );
              },
              backgroundColor: ColorsManager.black,
            ),
          ],
        ),
      ),
    );
  }
}
