import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/check_card.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_appbar.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

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
              ///////////////////////////////////////////////////////
              /// this is just dummy data and it will be added in future as object at provider to make it more formatted
              /// it will be a separated widget in future
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorsManager.grey300)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/free-photo/room-interior-hotel-bedroom_23-2150683419.jpg?t=st=1745259268~exp=1745262868~hmac=2eafe526e38eedf78d670478b7358b1694347c7b043d9118a27d9b26db1e36ea&w=1380',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: const Icon(Icons.image, size: 30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Estabeez Hotel',
                                style: TextStyleManager.blackBold16,
                              ),
                              Icon(Icons.favorite_border,
                                  color: ColorsManager.grey600),
                            ],
                          ),
                          const Text('Ikoyi, Lagos',
                              style: TextStyleManager.greyRegular14),
                          Text(
                              'NGN ${NumberFormat('#,###').format(bookingProvider.roomPrice)}/night',
                              style: TextStyleManager.greyRegular14),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '4.8',
                                style: TextStyleManager.blackSemiBold15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////////////////////////////////////
              const SizedBox(height: 24),
              _room_Details_Section(bookingProvider),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Confirm Payment',
                onPressed: () {
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
                    Navigator.of(context).pop();
                  },
                  backgroundColor: ColorsManager.black,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
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
          _oneLineText('Total',
              "NGN ${NumberFormat('#,###').format(bookingProvider.calculateCost())}"),
        ],
      ),
    );
  }
}
