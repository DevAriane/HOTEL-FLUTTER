import 'package:flutter/material.dart';
import 'package:hotel/controllers/favorites_controller.dart';
import 'package:hotel/widgets/hotel_card.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favController = Get.find<FavoritesController>();

    return Scaffold(
      body: Obx(() {
        if (favController.favoriteHotels.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                SizedBox(height: 20),
                Text('Aucun favori', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        } else {
          return ListView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 7,
              top: 30,
              bottom: 85,
            ),
            children: favController.favoriteHotels
                .map((hotel) => HotelCard(hotel))
                .toList(),
          );
        }
      }),
    );
  }
}
