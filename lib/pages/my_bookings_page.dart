import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/services/hotel_service.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final objectBox = Get.find<ObjectBoxService>();
    final bookings = objectBox.getAllBookings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Réservations'),
        backgroundColor: Colors.white,
      ),
      body: bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history_edu, size: 80, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    'Aucune réservation',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: bookings.length,
              itemBuilder: (ctx, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        booking.hotelPicture,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      booking.hotelTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(booking.hotelPlace),
                        Text(
                          'Du ${booking.startDate.day}/${booking.startDate.month}'
                          ' au ${booking.endDate.day}/${booking.endDate.month}',
                        ),
                        Text(
                          'Total : ${booking.totalPrice} FCFA',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
