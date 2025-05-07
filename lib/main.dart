import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/providers/calender_provider.dart';
import 'package:flutter_application_1/favorites/providers/favorites_provider.dart';
import 'package:flutter_application_1/favorites/screen/favorites_screen.dart';
import 'package:flutter_application_1/home/hotel_bloc/hotel_bloc.dart';
import 'package:flutter_application_1/home/screens/hotel_listing_screen.dart';
import 'package:flutter_application_1/home/services/sample_data.dart';
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
    const FavoritesScreen(),
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
