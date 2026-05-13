import 'package:objectbox/objectbox.dart';

@Entity()
class FavoriteEntity {
  @Id()
  int id = 0;
  int hotelId;
  FavoriteEntity({this.id = 0, required this.hotelId});
}
