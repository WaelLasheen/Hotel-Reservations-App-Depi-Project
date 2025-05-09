import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_history/widgets/booking_row_info.dart';
import 'package:flutter_application_1/core/models/booking.dart';
import 'package:flutter_application_1/booking_history/widgets/booking_details_widgets.dart';
import 'package:intl/intl.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailsScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM dd, yyyy');
    final currencyFormat = NumberFormat.currency(symbol: 'EGP ');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: booking.hotel.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 50),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black54),
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.white54,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.hotel.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        booking.hotel.location,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BookingDetailsSection(
                    title: 'Booking Details',
                    children: [
                      BookingInfoRow(
                        label: 'Check-in',
                        value: dateFormat.format(booking.startDate),
                      ),
                      BookingInfoRow(
                        label: 'Check-out',
                        value: dateFormat.format(booking.endDate),
                      ),
                      BookingInfoRow(
                        label: 'Number of Guests',
                        value: booking.numberOfGuests.toString(),
                      ),
                      BookingInfoRow(
                        label: 'Number of Rooms',
                        value: booking.numberOfRooms.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BookingDetailsSection(
                    title: 'Guest Information',
                    children: [
                      BookingInfoRow(
                        label: 'Name',
                        value:
                            '${booking.client.firstName} ${booking.client.lastName}',
                      ),
                      BookingInfoRow(
                        label: 'Email',
                        value: booking.client.email,
                      ),
                      BookingInfoRow(
                        label: 'Phone',
                        value: booking.client.phoneNumber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BookingDetailsSection(
                    title: 'Hotel Information',
                    children: [
                      BookingInfoRow(
                        label: 'Description',
                        value: booking.hotel.description,
                      ),
                      BookingInfoRow(
                        label: 'Rating',
                        value:
                            '${booking.hotel.rating} (${booking.hotel.reviewCount} reviews)',
                      ),
                      BookingInfoRow(
                        label: 'Price per night',
                        value: currencyFormat.format(booking.hotel.price),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
