import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../models/hotel_model.dart';
import 'package:get/get.dart';
import 'package:hotel/models/booking_entity.dart';
import 'package:hotel/services/hotel_service.dart';

class BookingSummaryPage extends StatelessWidget {
  final Hotel hotel;
  final DateTime start;
  final DateTime end;
  final int guests;
  final int bedrooms;
  final String specialRequest;


  const BookingSummaryPage({
    super.key,
    required this.hotel,
    required this.start,
    required this.end,
    required this.bedrooms,
    required this.guests,
    required this.specialRequest,
  });

  @override
  Widget build(BuildContext context) {
    int days = end.difference(start).inDays;
    int totalPrice = days * hotel.price;

    return Scaffold(
      appBar: MyAppBar(title: 'Récapitulatif',hotelData: hotel),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: Image.asset(hotel.picture, width: 60),
                title: Text(hotel.title),
                subtitle: Text(hotel.place),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Détails',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildInfoRow(
              'DATES',
              '${start.day}/${start.month} - ${end.day}/${end.month}',
            ),
            _buildInfoRow('DURÉE', '$days jours'),
            _buildInfoRow('PRIX TOTAL', '$totalPrice FCFA'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$totalPrice FCFA',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final objectBox = Get.find<ObjectBoxService>();
                      final booking = BookingEntity(
                        hotelId: hotel.id,
                        startDate: start,
                        endDate: end,
                        totalPrice: totalPrice,
                        hotelTitle: hotel.title,
                        hotelPlace: hotel.place,
                        hotelPicture: hotel.picture,
                      );

                      await objectBox.addBooking(booking);

                      Get.snackbar(
                        'Succès',
                        'Votre réservation à "${hotel.title}" est confirmée !',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    child: const Text(
                      'PAYER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Text('Modifier', style: TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }
}
