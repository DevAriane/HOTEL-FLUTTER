import 'package:objectbox/objectbox.dart';

@Entity()
class BookingEntity {
  @Id()
  int id = 0;

  int hotelId;
  @Property(type: PropertyType.date)
  DateTime startDate;
  @Property(type: PropertyType.date)
  DateTime endDate;
  int totalPrice;

  String hotelTitle;
  String hotelPlace;
  String hotelPicture;

  BookingEntity({
    this.id = 0,
    required this.hotelId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.hotelTitle,
    required this.hotelPlace,
    required this.hotelPicture,
  });
}
