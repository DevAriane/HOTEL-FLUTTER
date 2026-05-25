import 'package:flutter/material.dart';
import 'package:hotel/app_color.dart';
import '../models/hotel_model.dart';
import 'package:get/get.dart';
import '../pages/home_content.dart';
import '../pages/my_bookings_page.dart';

class BookingSummaryPage extends StatelessWidget {
  final Hotel hotel;
  final DateTime checkIn;
  final DateTime checkOut;
  final int nights;
  final double totalPrice;
  final int guests;
  final int bedrooms;
  final String specialRequest;

  const BookingSummaryPage({
    super.key,
    required this.hotel,
    required this.checkIn,
    required this.checkOut,
    required this.nights,
    required this.totalPrice,
    required this.guests,
    required this.bedrooms,
    required this.specialRequest,
  });

  String _formatDate(DateTime date) {
    String jour = date.day.toString().padLeft(2, '0');
    String mois = date.month.toString().padLeft(2, '0');
    return "$jour/$mois/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Résumé de la réservation"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(hotel.picture, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ta réservation a bien été confirmée",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Vous avez reçu un e-mail de confirmation pour votre réservation.",
                  style: TextStyle(color: AppColor.pewter),
                ),
                const SizedBox(height: 25),
                _buildInfoRow(
                  icon: Icons.calendar_month,
                  label: "Début de consommation",
                  value: _formatDate(checkIn),
                ),
                const SizedBox(height: 15),
                _buildInfoRow(
                  icon: Icons.calendar_month,
                  label: "Fin de consommation",
                  value: _formatDate(checkOut),
                ),
                const SizedBox(height: 15),
                _buildInfoRow(
                  icon: Icons.nightlight_round,
                  label: "Nombre de nuits",
                  value: "$nights",
                ),
                const SizedBox(height: 15),
                _buildInfoRow(
                  icon: Icons.people,
                  label: "Nombre de places",
                  value: "$guests",
                ),
                const SizedBox(height: 15),
                _buildInfoRow(
                  icon: Icons.payments,
                  label: "Montant à payer",
                  value: "${totalPrice.toStringAsFixed(2)} FCFA",
                  isPrice: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColor.noir,
                      )),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Get.to(MyBookingsPage());
                          },
                          child: Text(
                            "Retour a l'accueil",
                            style: TextStyle(color: AppColor.dGreen),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isPrice = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColor.pewter, size: 20),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontSize: 15)),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isPrice ? FontWeight.bold : FontWeight.w500,
          ),
        )
      ],
    );
  }
}
