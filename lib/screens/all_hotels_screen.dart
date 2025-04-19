import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../services/sample_data.dart';
import '../widgets/hotel_card.dart';
import 'hotel_details_screen.dart';

class AllHotelsScreen extends StatelessWidget {
  final String title;
  final List<Hotel> hotels;

  const AllHotelsScreen({
    super.key,
    required this.title,
    required this.hotels,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailsScreen(
                      hotel: hotels[index],
                    ),
                  ),
                );
              },
              child: HotelCard(
                hotel: hotels[index],
                isHorizontal: true,
              ),
            ),
          );
        },
      ),
    );
  }
} 