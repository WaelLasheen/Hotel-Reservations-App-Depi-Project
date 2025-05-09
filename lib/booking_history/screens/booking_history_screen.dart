import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/booking.dart';
import 'package:flutter_application_1/core/provider/booking_history_provider.dart';
import 'package:flutter_application_1/booking_history/screens/booking_details_screen.dart';
import 'package:flutter_application_1/booking_history/widgets/booking_history_item.dart';
import 'package:provider/provider.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        elevation: 0,
      ),
      body: Consumer<BookingHistoryProvider>(
        builder: (context, bookingsHistoryProvider, _) {
          final List<Booking> bookings = bookingsHistoryProvider.bookings;
          final bool isLoading = bookingsHistoryProvider.isLoading;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return bookings.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No bookings yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return Dismissible(
                      key: Key(booking.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Delete Booking?"),
                            content: const Text(
                                "Are you sure you want to delete this booking?"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Delete")),
                            ],
                          ),
                        );
                      },
                      onDismissed: (_) {
                        bookingsHistoryProvider.deleteBooking(booking.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Booking deleted")),
                        );
                      },
                      child: BookingHistoryItem(
                        booking: booking,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetailsScreen(
                                booking: booking,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}