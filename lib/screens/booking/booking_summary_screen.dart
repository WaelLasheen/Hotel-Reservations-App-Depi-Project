import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/booking/booking_provider.dart';
import '../../widgets/booking/custom_appbar.dart';
import '../../widgets/booking/custom_button.dart';
import '../../utils/text_styles_manager.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Booking Summary'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Booking Details',
                style: TextStyleManager.blackBold20,
              ),
              const SizedBox(height: 16),
              Consumer<BookingProvider>(
                builder: (context, bookingProvider, _) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Check In',
                          bookingProvider.dateToString(bookingProvider.startDate),
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Check Out',
                          bookingProvider.dateToString(bookingProvider.endDate),
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Number of Guests',
                          bookingProvider.numberOfGuests.toString(),
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Number of Rooms',
                          bookingProvider.numberOfRooms.toString(),
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Price per Room per Day',
                          '\$${bookingProvider.roomPrice}',
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Total Price',
                          '\$${bookingProvider.calculateTotalPrice()}',
                          isTotal: true,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 36),
              CustomButton(
                text: 'Confirm Booking',
                onPressed: () {
                  // TODO: Implement booking confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking confirmed successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }
} 