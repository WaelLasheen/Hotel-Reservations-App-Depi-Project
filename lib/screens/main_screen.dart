import 'package:flutter/material.dart';
import 'hotel_listing_screen.dart';
import '../services/hive_service.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    const HotelListingScreen(),
    const Center(child: Text('Bookings')), // Placeholder for Bookings screen
    const FavoritesScreen(),
    const ProfileScreen(), // Using our new ProfileScreen
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = HiveService.settings.lastSelectedTab;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    HiveService.updateLastSelectedTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
} 