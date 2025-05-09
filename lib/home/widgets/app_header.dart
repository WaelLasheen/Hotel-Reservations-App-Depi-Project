import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_1/search/search_delegate.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 120,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
          color: Colors.white,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d',
                ),
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
              const SearchPage(),
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
    );
  }
}
