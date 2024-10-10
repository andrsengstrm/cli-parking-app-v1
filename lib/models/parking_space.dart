import 'package:uuid/uuid.dart';
var uuid = Uuid();

class ParkingSpace {
  String id;
  String address;
  double pricePerHour;

  ParkingSpace({String? id, required this.address, required this.pricePerHour}) : id = id ?? uuid.v1();

  String get printDetails => "$id $address $pricePerHour";

}