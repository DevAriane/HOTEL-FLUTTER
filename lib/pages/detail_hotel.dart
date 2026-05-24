import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/models/hotel_model.dart';
import 'package:hotel/app_color.dart';
import 'calendar_page.dart';
import '../controllers/favorites_controller.dart';

class DetailHotel extends StatelessWidget {
  final Hotel hotel;

  const DetailHotel({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blancFume,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(hotel.picture),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.black.withValues(alpha: 0.25),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Aligne les deux boutons verticalement
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColor.blanc.withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_back,
                                    color: AppColor.dGreen),
                              ),
                            ),
                            //  CORRECTION : Le Positioned inutile et problématique a été retiré d'ici
                            Obx(() {
                              final isFav = Get.find<FavoritesController>()
                                  .isFavorite(hotel);
                              return SizedBox(
                                width: 40,
                                height: 40,
                                child: Material(
                                  color: Colors.white,
                                  shape: const CircleBorder(),
                                  elevation: 2,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      Get.find<FavoritesController>()
                                          .toggleFavorite(hotel);
                                    },
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFav
                                          ? AppColor.dGreen
                                          : AppColor.pewter,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.title,
                        style: GoogleFonts.nunito(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColor.noir,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: AppColor.pewter, size: 18),
                              const SizedBox(width: 5),
                              Text(
                                hotel.place,
                                style: GoogleFonts.nunito(
                                  color: AppColor.pewter,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 5),
                              Text(
                                "${hotel.rating}",
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.noir,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Équipements",
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.noir,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            amenityCard(Icons.wifi, "Wifi"),
                            amenityCard(Icons.local_parking, "Parking"),
                            amenityCard(Icons.pool, "Piscine"),
                            amenityCard(Icons.restaurant, "Restaurant"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Description",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.noir,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        hotel.description,
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          color: AppColor.pewter,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Ce Positioned ci est correct car son parent direct est le Stack du Scaffold body
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.blanc,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${hotel.price} FCFA",
                          style: GoogleFonts.nunito(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.dGreen,
                          ),
                        ),
                        TextSpan(
                          text: " / nuit",
                          // style: GoogleFonts.silver,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.dGreen,
                      foregroundColor: AppColor.blanc,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.to(() => CalendarPage(hotel: hotel));
                    },
                    child: Text(
                      "Réserver",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget amenityCard(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.silver),
        color: AppColor.blanc,
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColor.dGreen, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 13,
              color: AppColor.noir,
            ),
          ),
        ],
      ),
    );
  }
}
