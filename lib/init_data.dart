import 'package:cli/models/parking_space.dart';
import 'package:cli/models/person.dart';
import 'package:cli/models/vehicle.dart';
import 'package:cli/repositories/parking_space_repository.dart';
import 'package:cli/repositories/person_repsoitory.dart';
import 'package:cli/repositories/vehicle_repository.dart';

void initData() {
  Person person = Person(personId: "7211097550", name: "Anders");
  PersonRepository().add(person);
  Vehicle vehicle = Vehicle(regId: "LUP767", vehicleType: VehicleType.bil, ownerId: person.id);
  VehicleRepository().add(vehicle);
  ParkingSpace parkingSpace = ParkingSpace(address: "Paulusväg 13, Bålsta", pricePerHour: 29);
  ParkingSpaceRepository().add(parkingSpace);
}