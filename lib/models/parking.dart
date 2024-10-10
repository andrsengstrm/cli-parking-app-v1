import 'package:cli/models/parking_space.dart';
import 'package:cli/models/vehicle.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Parking {
  String id;
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  double startTime;
  double? endTime;

  Parking({String? id, required this.vehicle, required this.parkingSpace, required this.startTime, this.endTime}) : id = id ?? uuid.v1();

  

}