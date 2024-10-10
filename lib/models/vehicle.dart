import 'package:cli/models/person.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Vehicle {
  String id;
  String regId;
  VehicleType vehicleType;
  Person owner;

  Vehicle({String? id, required this.regId, required this.vehicleType, required this.owner }) : id = id ?? uuid.v1();

  String get printDetails => "$id $regId ${vehicleType.name.toUpperCase()} ${owner.name}";

}

enum VehicleType { 
  bil, mc, lastbil, ospecificerad;
}
 