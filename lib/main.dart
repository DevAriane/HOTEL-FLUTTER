import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'services/hotel_service.dart';
import 'main_layout.dart';
import 'controllers/favorites_controller.dart';
import 'pages/screen.dart';
import 'controllers/hotel_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectBoxService = await ObjectBoxService().init();
  Get.put(objectBoxService);

  final hotelController = HotelController();

  Get.put(HotelController());

  Get.put(FavoritesController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotels Booking',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Screen()),
        GetPage(name: '/second', page: () => const MainLayout())
      ],
    );
  }
}
