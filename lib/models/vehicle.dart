import 'package:cli/models/person.dart';
import 'package:cli/repositories/person_repsoitory.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Vehicle {
  final String id;
  String regId;
  VehicleType vehicleType;
  String ownerId;

  Vehicle({String? id, required this.regId, required this.vehicleType, required this.ownerId }) : id = id ?? uuid.v1();

  String get printDetails => "$id $regId ${vehicleType.name.toUpperCase()} ${PersonRepository().getPersonById(ownerId).name}";

}

enum VehicleType { 
  bil, mc, lastbil, ospecificerad;
}
 