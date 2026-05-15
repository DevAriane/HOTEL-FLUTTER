import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hotel/controllers/favorites_controller.dart';
import 'package:hotel/models/hotel_model.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Hotel? hotelData;

  const MyAppBar({super.key, required this.title, required this.hotelData});

  @override
  Size get preferredSize => Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: (() => Get.back()),
        icon: Icon(Icons.arrow_back, color: Colors.grey[800], size: 20),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (hotelData != null)
          IconButton(
            onPressed: () {
              Get.find<FavoritesController>().toggleFavorite(hotelData!);
            },
            icon: Icon(
              Icons.favorite_outline_rounded,
              color: Colors.grey[800],
              size: 20,
            ),
          ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
