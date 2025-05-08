import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/provider/booking_history_provider.dart';
import 'package:provider/provider.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingHistoryProvider bookingsHistoryProvider =
        Provider.of<BookingHistoryProvider>(context);
    final bookings = bookingsHistoryProvider.bookings;

    return Scaffold(
        appBar: AppBar(title: const Text('Booking History')),
        body: ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final b = bookings[index];
            return Dismissible(
              key: Key(b.id.toString()),
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
                bookingsHistoryProvider.deleteBooking(b.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Booking deleted")),
                );
              },
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: b.hotel.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 30),
                  ),
                ),
                title: Text(b.hotel.name),
                subtitle: Text(
                    '${b.client.firstName} ${b.client.lastName}\nGuests: ${b.numberOfGuests}'),
                isThreeLine: true,
              ),
            );
          },
        ));
  }
}
