import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:flutter_application_1/core/provider/hotel_provider.dart';
import 'package:flutter_application_1/hotel_details/hotel_details_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/app_header.dart';
import '../widgets/hotel_section.dart';
import 'all_hotels_screen.dart';

class HotelListingScreen extends StatelessWidget {
  const HotelListingScreen({super.key});

  void _navigateToHotelDetails(BuildContext context, Hotel hotel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetailsScreen(hotel: hotel),
      ),
    );
  }

  void _navigateToAllHotels(
      BuildContext context, String title, List<Hotel> hotels) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllHotelsScreen(
          title: title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HotelProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          const AppHeader(),
          SliverPadding(
            padding: const EdgeInsets.only(top: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  HotelSection(
                    title: 'Popular Hotels',
                    hotels: provider.getPopularHotels(),
                    onViewAll: () => _navigateToAllHotels(
                      context,
                      'Popular Hotels',
                      provider.getPopularHotels(),
                    ),
                    onHotelTap: (Hotel hotel) =>
                        _navigateToHotelDetails(context, hotel),
                    isHorizontal: false,
                  ),
                  const SizedBox(height: 24),
                  HotelSection(
                    title: 'Special Offers',
                    hotels: provider.getSpecialOffers(),
                    onViewAll: () => _navigateToAllHotels(
                      context,
                      'Special Offers',
                      provider.getSpecialOffers(),
                    ),
                    onHotelTap: (Hotel hotel) =>
                        _navigateToHotelDetails(context, hotel),
                    isHorizontal: true,
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
