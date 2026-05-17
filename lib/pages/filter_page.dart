import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hotel_controller.dart';

class FilterPage extends StatelessWidget {
  final HotelController controller = Get.find<HotelController>();

  FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filtres')),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       Obx(() => Column(
      //             children: [
      //               Text(
      //                   'Prix minimum : ${controller.minPrice.value.toInt()} €'),
      //               Slider(
      //                 value: controller.minPrice.value,
      //                 min: 0,
      //                 max: 500,
      //                 divisions: 50,
      //                 onChanged: (v) => controller.setMinPrice(v),
      //               ),
      //             ],
      //           )),
      //       Obx(() => Column(
      //             children: [
      //               Text(
      //                   'Prix maximum : ${controller.maxPrice.value.toInt()} €'),
      //               Slider(
      //                 value: controller.maxPrice.value,
      //                 min: 0,
      //                 max: 1000,
      //                 divisions: 100,
      //                 onChanged: (v) => controller.setMaxPrice(v),
      //               ),
      //             ],
      //           )),
      //       SizedBox(height: 20),
      //       TextField(
      //         decoration: InputDecoration(labelText: 'Titre (ex: Alvi)'),
      //         onChanged: (value) => controller.setSearchTitle(value),
      //       ),
      //       SizedBox(height: 20),
      //       TextField(
      //         decoration: InputDecoration(labelText: 'Lieu (ex: Douala)'),
      //         onChanged: (value) => controller.setSearchPlace(value),
      //       ),
      //       SizedBox(height: 30),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           ElevatedButton(
      //             onPressed: () => controller.resetFilters(),
      //             child: Text('Réinitialiser'),
      //           ),
      //           ElevatedButton(
      //             onPressed: () => Get.back(),
      //             child: Text('Appliquer'),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
