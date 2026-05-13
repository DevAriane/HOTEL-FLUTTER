import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_bookings_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Mon Profile', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Get.to(() => MyBookingsPage()),
            child: Text('Voir mes réservations'),
          ),
        ],
      ),
    );
  }
}
