import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_history/screens/booking_history_screen.dart';
import 'package:flutter_application_1/core/provider/hotel_provider.dart';
import 'package:flutter_application_1/core/provider/client_provider.dart';
import 'package:flutter_application_1/core/provider/booking_history_provider.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/favorites/screen/favorites_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: ColorsManager.primary,
        foregroundColor: ColorsManager.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: ColorsManager.grey300,
              child: const Icon(
                Icons.person,
                size: 50,
                color: ColorsManager.grey,
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ClientProvider>(
              builder: (context, clientProvider, child) {
                final client = clientProvider.currentClient;
                return Column(
                  children: [
                    Text(
                      client != null
                          ? '${client.firstName} ${client.lastName}'
                          : 'Guest',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      client?.email ?? 'Not logged in',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorsManager.grey600,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<BookingHistoryProvider>(
                    builder: (context, bookingProvider, child) {
                      return _buildStatItem(
                        'Bookings',
                        bookingProvider.bookings.length.toString(),
                      );
                    },
                  ),
                  _buildStatItem('Reviews', '8'),
                  _buildStatItem('Points', '1,250'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildMenuItem(
              icon: Icons.history,
              title: 'Booking History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingHistoryScreen(),
                  ),
                );
              },
            ),
            Consumer<HotelProvider>(
              builder: (context, hotelProvider, child) {
                final savedHotelsCount = hotelProvider.favorites.length;
                return _buildMenuItem(
                  icon: Icons.favorite,
                  title: 'Saved Hotels',
                  subtitle: '$savedHotelsCount hotels saved',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesScreen(),
                      ),
                    );
                  },
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.payment,
              title: 'Payment Methods',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {},
            ),
            const Divider(height: 32),
            // Delete Account Option
            Consumer<ClientProvider>(
              builder: (context, clientProvider, child) {
                return _buildMenuItem(
                  icon: Icons.delete_forever,
                  title: 'Delete Account',
                  textColor: ColorsManager.error,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                            'Are you sure you want to delete your account? This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final email = clientProvider.currentClient?.email;
                              if (email != null) {
                                await clientProvider.logout();
                                Navigator.pop(context); 
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/welcome',
                                  (route) =>
                                      false, 
                                );
                              }
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: ColorsManager.error),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsManager.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: ColorsManager.grey600,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? ColorsManager.primary),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? ColorsManager.primary),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
