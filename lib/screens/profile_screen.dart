import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings navigation
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
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            // Name
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Email
            const Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            // Stats Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Bookings', '12'),
                  _buildStatItem('Reviews', '8'),
                  _buildStatItem('Points', '1,250'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Menu Items
            _buildMenuItem(
              icon: Icons.history,
              title: 'Booking History',
              onTap: () {
                // TODO: Implement booking history navigation
              },
            ),
            Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                final savedHotelsCount = favoritesProvider.favorites.length;
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
              onTap: () {
                // TODO: Implement payment methods navigation
              },
            ),
            _buildMenuItem(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                // TODO: Implement notifications navigation
              },
            ),
            _buildMenuItem(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {
                // TODO: Implement help & support navigation
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
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
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
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 