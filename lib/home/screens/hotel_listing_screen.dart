import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:flutter_application_1/home/hotel/hotel_bloc.dart';
import 'package:flutter_application_1/home/hotel/hotel_event.dart';
import 'package:flutter_application_1/home/hotel/hotel_state.dart';
import 'package:flutter_application_1/hotel_details/hotel_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_header.dart';
import '../widgets/hotel_section.dart';
import 'all_hotels_screen.dart';

class HotelListingScreen extends StatelessWidget {
  const HotelListingScreen({super.key});

  void _navigateToHotelDetails(BuildContext context, Hotel hotel) {
    context.read<HotelBloc>().add(SelectHotel(hotel.id));
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
          hotels: hotels,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        if (state is HotelInitial || state is HotelLoading) {
          context.read<HotelBloc>().add(const LoadHotels());
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HotelError) {
          return Center(child: Text(state.message));
        }

        if (state is HotelLoaded) {
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
                          hotels: state.popularHotels,
                          onViewAll: () => _navigateToAllHotels(
                            context,
                            'Popular Hotels',
                            state.popularHotels,
                          ),
                          onHotelTap: (Hotel hotel) =>
                              _navigateToHotelDetails(context, hotel),
                          isHorizontal: false,
                        ),
                        const SizedBox(height: 24),
                        HotelSection(
                          title: 'Special Offers',
                          hotels: state.specialOffers,
                          onViewAll: () => _navigateToAllHotels(
                            context,
                            'Special Offers',
                            state.specialOffers,
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

        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}
