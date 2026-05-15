import 'package:flutter/material.dart';
import '../data/hotel_data.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar.dart';
import 'package:hotel/widgets/hotel_card.dart';

class SearchResultsPage extends StatelessWidget {
  final String SearchQuery;

  const SearchResultsPage({super.key, required this.SearchQuery});

  @override
  Widget build(BuildContext context) {
    final hotels = context.watch<HotelProvider>().hotels;
    final results = hotels.where((hotel) {
      return hotel.title.toLowerCase().contains(SearchQuery.toLowerCase()) ||
          hotel.place.toLowerCase().contains(SearchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: MyAppBar(
          title: "Resultat de recherche pour ${SearchQuery}", hotelData: null),
      body: results.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 80, color: Colors.grey[600]),
                  SizedBox(height: 16),
                  Text(
                    'aucun hotel trouve',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'essayez Douala ou Yaounde',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return HotelCard(results[index]);
              },
            ),
    );
  }
}
