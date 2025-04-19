import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hotel.dart';
import '../widgets/hotel_card.dart';
import '../blocs/hotel/hotel_bloc.dart';
import '../blocs/hotel/hotel_event.dart';
import '../blocs/hotel/hotel_state.dart';
import 'all_hotels_screen.dart';
import 'hotel_details_screen.dart';

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

  void _navigateToAllHotels(BuildContext context, String title, List<Hotel> hotels) {
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
    final theme = Theme.of(context);
    
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        if (state is HotelInitial) {
          context.read<HotelBloc>().add(const LoadHotels());
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HotelLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HotelError) {
          return Center(child: Text(state.message));
        }

        if (state is HotelLoaded) {
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  expandedHeight: 90,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                      color: Colors.white,
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d'),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Find hotels near',
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    'Cairo, Egypt',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: theme.colorScheme.primary,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: theme.colorScheme.primary,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular Hotels',
                                style: theme.textTheme.titleLarge,
                              ),
                              TextButton(
                                onPressed: () => _navigateToAllHotels(
                                  context,
                                  'Popular Hotels',
                                  state.popularHotels,
                                ),
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 284,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.popularHotels.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index != state.popularHotels.length - 1 ? 16 : 0,
                                ),
                                child: GestureDetector(
                                  onTap: () => _navigateToHotelDetails(
                                    context,
                                    state.popularHotels[index],
                                  ),
                                  child: HotelCard(
                                    hotel: state.popularHotels[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Special Offers',
                                style: theme.textTheme.titleLarge,
                              ),
                              TextButton(
                                onPressed: () => _navigateToAllHotels(
                                  context,
                                  'Special Offers',
                                  state.specialOffers,
                                ),
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: state.specialOffers.map((hotel) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GestureDetector(
                                onTap: () => _navigateToHotelDetails(context, hotel),
                                child: HotelCard(
                                  hotel: hotel,
                                  isHorizontal: true,
                                ),
                              ),
                            )).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
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