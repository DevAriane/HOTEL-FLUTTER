import 'package:get/get.dart';
import 'package:hotel/services/hotel_service.dart';
import '../models/booking_entity.dart';

class BookingController extends GetxController {
  var bookingHotel = <BookingEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final objectbox = Get.find<ObjectBoxService>();
    _loodBookingHotel(objectbox);
  }

  void _loodBookingHotel(ObjectBoxService objectbox) {
    final list = objectbox.getAllBookings();
    bookingHotel.assignAll(list);
  }

  void refreshBookings() {
    final objectbox = Get.find<ObjectBoxService>();
    _loodBookingHotel(objectbox);
  }

  Future<void> createNewBooking(BookingEntity newBooking) async {
    final objectbox = Get.find<ObjectBoxService>();

    await objectbox.addBooking(newBooking);

    _loodBookingHotel(objectbox);
  }
}
