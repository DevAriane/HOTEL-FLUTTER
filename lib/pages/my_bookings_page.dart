import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller (it will be auto-disposed if needed)
    final BookingController controller = Get.find<BookingController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Réservations'),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        // ← Reactive update when bookingHotel changes
        final bookings = controller.bookingHotel;
        if (bookings.isEmpty) {
          return Center(
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
          );
        }
        return ListView.builder(
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
                    child: Image.network(
                      booking.hotelPicture,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image,
                              color: Colors.grey),
                        );
                      },
                    )),
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
        );
      }),
    );
  }
}
