import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/provider/client_provider.dart';
import 'package:flutter_application_1/auth/screens/login_screen.dart';
import 'package:flutter_application_1/auth/screens/signup_screen.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/providers/calender_provider.dart';
import 'package:flutter_application_1/booking_history/screens/booking_history_screen.dart';
import 'package:flutter_application_1/core/provider/booking_history_provider.dart';
import 'package:flutter_application_1/core/provider/hotel_provider.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/database/hotel_database_helper.dart';
import 'package:flutter_application_1/favorites/screen/favorites_screen.dart';
import 'package:flutter_application_1/home/screens/hotel_listing_screen.dart';
import 'package:flutter_application_1/database/data/sample_data.dart';
import 'package:flutter_application_1/profile/screen/profile_screen.dart';
import 'package:flutter_application_1/splash/screen/splash_screen.dart';
import 'package:flutter_application_1/splash/screen/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hotels = await HotelDatabase.getHotels();
  if (hotels.isEmpty) {
    SampleData().insertTestCase();
  }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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
    const BookingHistoryScreen(),
    const FavoritesScreen(),
    const ProfileScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalenderProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => HotelProvider()..loadHotels()),
        ChangeNotifierProvider(
            create: (_) => BookingHistoryProvider()..loadBookings()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
      ],
      child: MaterialApp(
        title: 'CozyGo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorsManager.primary,
            primary: ColorsManager.primary,
            secondary: ColorsManager.secondary,
            tertiary: ColorsManager.accent,
            background: ColorsManager.background,
            surface: ColorsManager.surface,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorsManager.surface,
            foregroundColor: ColorsManager.primary,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: ColorsManager.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: ColorsManager.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              color: ColorsManager.primary,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: ColorsManager.secondary,
              fontSize: 14,
            ),
          ),
          cardTheme: CardTheme(
            color: ColorsManager.surface,
            elevation: 4,
            shadowColor: ColorsManager.primary.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: ColorsManager.surface,
            selectedItemColor: ColorsManager.primary,
            unselectedItemColor: ColorsManager.secondary,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => Scaffold(
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
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: ColorsManager.primary,
                  unselectedItemColor: ColorsManager.secondary,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        _currentIndex == 1
                            ? Icons.calendar_today
                            : Icons.calendar_today_outlined,
                      ),
                      label: 'Bookings',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        _currentIndex == 2
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: 'Saved',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        _currentIndex == 3
                            ? Icons.person
                            : Icons.person_outline,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
        },
      ),
    );
  }
}
