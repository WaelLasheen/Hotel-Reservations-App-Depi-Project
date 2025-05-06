import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/providers/calender_provider.dart';
import 'package:flutter_application_1/booking_form/screens/booking_form_screen_one.dart';
import 'package:flutter_application_1/favorites/providers/favorites_provider.dart';
import 'package:flutter_application_1/favorites/screen/favorites_screen.dart';
import 'package:flutter_application_1/home/hotel/hotel_bloc.dart';
import 'package:flutter_application_1/home/screens/hotel_listing_screen.dart';
import 'package:flutter_application_1/home/services/sample_data.dart';
import 'package:flutter_application_1/hotel_details/hotel_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _screens = [
    const HotelListingScreen(),
    const Center(child: Text('Bookings')),
    const Center(child: Text('Saved')),
    const Center(child: Text('Profile'))
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelBloc(hotelService: SampleData()),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CalenderProvider()),
          ChangeNotifierProvider(create: (_) => BookingProvider()),
          ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ],
        child: MaterialApp(
          title: 'CozyGo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2B2D42),
              primary: const Color(0xFF2B2D42),
              secondary: const Color(0xFF8D99AE),
              tertiary: const Color(0xFFEF233C),
              background: const Color(0xFFEDF2F4),
              surface: Colors.white,
            ),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF2B2D42),
              elevation: 0,
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Color(0xFF2B2D42),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                color: Color(0xFF2B2D42),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              bodyLarge: TextStyle(
                color: Color(0xFF2B2D42),
                fontSize: 16,
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF8D99AE),
                fontSize: 14,
              ),
            ),
            cardTheme: CardTheme(
              color: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF2B2D42).withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xFF2B2D42),
              unselectedItemColor: Color(0xFF8D99AE),
              type: BottomNavigationBarType.fixed,
              elevation: 8,
            ),
          ),

          // form -> Wael
          // home: const BookingFormScreenOne(
          //   costPerRoomPerDay: 100,
          // ),

          // favorites -> Minnah
          // home: const FavoritesScreen()

          // hotel details -> Walied
          //   home: HotelDetailsScreen(
          //   hotel: Hotel(
          //     name: 'Imperial Hotel',
          //     pricePerNight: 269,
          //     rating: 4.6,
          //     reviewCount: 256,
          //     description:
          //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In leo pulvinar leo aliquam pharetra enim venenatis quam orci. Volutpat adipiscing et aenean nulla scelerisque at blandit. Sed ut turpis adipiscing nulla lectus maecenas lh...... ',
          //     imageUrl:
          //         'https://cf.bstatic.com/xdata/images/hotel/max500/607574107.jpg?k=c37c2c5df49e1e9ebbb338c3f0077e7ef73f90e35abe770927acd4e50634b45e&o',
          //     galleryImages: [
          //       'https://cf.bstatic.com/xdata/images/hotel/max1280x900/607574071.jpg?k=b529f3b53ff7fe31fc34dcfb1d4e55da137487ef0c50d3464f1196fbb62a54b7&o=&hp=1',
          //       'https://cf.bstatic.com/xdata/images/hotel/max500/607574112.jpg?k=d7cd50e62593631a250899e6f35edeb091bccf53010a93674d9bbd0c03e345af&o',
          //       'https://cf.bstatic.com/xdata/images/hotel/max500/77824581.jpg?k=c96e2be2aeca4c2f335c085c8cd4de60ab6c307bb295d14b32d88bbd4fddf396&o',
          //       'https://cf.bstatic.com/xdata/images/hotel/max500/607574115.jpg?k=6f532852baf8694592420be945c254711e95974ea36111a379d4ef0ecd7f0867&o',
          //       'https://cf.bstatic.com/xdata/images/hotel/max500/29857346.jpg?k=a87128bed9b8c6f88e97aef3b92beaa31803686b07187b3450d3470988b83ef9&o',
          //     ],
          //   ),
          // ),

          // from -> Mohammed

          home: Scaffold(
            body: _screens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (_currentIndex != index) {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
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
          ),
        ),
      ),
    );
  }
}
