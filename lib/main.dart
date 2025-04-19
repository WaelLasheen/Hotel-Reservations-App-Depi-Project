import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/hotel_listing_screen.dart';
import 'blocs/hotel/hotel_bloc.dart';
import 'services/sample_data.dart';

void main() {
  runApp(const CozyGoApp());
}

class CozyGoApp extends StatelessWidget {
  const CozyGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelBloc(hotelService: SampleData()),
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
        home: const HotelListingScreen(),
      ),
    );
  }
}
