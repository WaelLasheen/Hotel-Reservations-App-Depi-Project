import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:flutter_application_1/core/provider/hotel_provider.dart';
import 'package:flutter_application_1/search/widgets/empty_state.dart';
import 'package:flutter_application_1/search/widgets/hotel_card.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(context: context, delegate: CustomSearchDelegate());
      },
      icon: const Icon(Icons.search),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Hotel> filtered = [];

  void filterResults(BuildContext context, String query) {
    List<Hotel> allHotels =
        Provider.of<HotelProvider>(context, listen: false).hotels;
    filtered = allHotels.where((hotel) {
      return hotel.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    filterResults(context, query);
    return filtered.isEmpty
        ? const EmptyState(
            icon: Icons.search_off,
            message: 'No hotels found',
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return HotelCard(hotel: filtered[index]);
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const EmptyState(
        icon: Icons.search,
        message: 'Start typing to search hotels',
      );
    }

    filterResults(context, query);
    return filtered.isEmpty
        ? const EmptyState(
            icon: Icons.search_off,
            message: 'No hotels found',
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return HotelCard(hotel: filtered[index]);
            },
          );
  }
}
