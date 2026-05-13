import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({super.key, required this.title});

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
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.favorite_outline_rounded,
            color: Colors.grey[800],
            size: 20,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.place, color: Colors.grey[800], size: 20),
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
