import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/check_card.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_appbar.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_button.dart';
import 'package:flutter_application_1/core/provider/booking_history_provider.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/booking_summary_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/booking_form/screens/booking_qr_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final BookingHistoryProvider bookingHistoryProvider =
        Provider.of<BookingHistoryProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Booking Summary',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _client_Details_Section(bookingProvider),
              const SizedBox(height: 16),
              const BookingSummaryCard(),
              const SizedBox(height: 24),
              _room_Details_Section(bookingProvider),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Confirm Payment',
                onPressed: () {
                  bookingHistoryProvider
                      .addBooking(bookingProvider.buildBooking());
                  _showPaymentSuccessDialog(context, bookingProvider);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentSuccessDialog(
      BuildContext context, BookingProvider bookingProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorsManager.grey300,
                  child: const Icon(
                    Icons.check_box_outline_blank,
                    color: ColorsManager.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Payment successful !',
                  style: TextStyleManager.blackSemiBold20,
                ),
                const SizedBox(height: 8),
                Text(
                  'Hi ${bookingProvider.firstName}, Your booking was successful',
                  style: TextStyleManager.greyRegular14,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'View Booking Ticket',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingQRScreen(),
                      ),
                    );
                  },
                  backgroundColor: ColorsManager.black,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (Route<dynamic> route) => false,
                    );
                  },
                  backgroundColor: ColorsManager.grey600,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _oneLineText(String text, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyleManager.grey600Regular16),
        Text(value, style: TextStyleManager.blackSemiBold15),
      ],
    );
  }

  Widget _client_Details_Section(BookingProvider bookingProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorsManager.grey300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _oneLineText('Name',
              "${bookingProvider.firstName} ${bookingProvider.lastName}"),
          const SizedBox(height: 16),
          _oneLineText('Email', bookingProvider.email),
          const SizedBox(height: 16),
          _oneLineText('Phone', bookingProvider.phoneNumber),
        ],
      ),
    );
  }

  Widget _room_Details_Section(BookingProvider bookingProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorsManager.grey300,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckCard(
                title: 'Check In',
                date: bookingProvider.dateToString(bookingProvider.startDate),
              ),
              CheckCard(
                title: 'Check Out',
                date: bookingProvider.dateToString(bookingProvider.endDate),
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _oneLineText('Guest', '${bookingProvider.numberOfGuests}'),
          const SizedBox(height: 16),
          _oneLineText('Number of rooms', '${bookingProvider.numberOfRooms}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyleManager.grey600Regular16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'EGP ${NumberFormat('#,###').format(bookingProvider.calculateCost())}',
                      style: TextStyleManager.blackSemiBold15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
