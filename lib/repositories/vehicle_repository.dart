import 'package:cli/models/vehicle.dart';
import 'package:cli/repositories/repository.dart';

class VehicleRepository extends Repository<Vehicle> {

  static final VehicleRepository _instance = VehicleRepository._internal();
  
  VehicleRepository._internal();

  factory VehicleRepository() => _instance;

  void printAllVehicles() {
    print("\nIndex Id Regnr Fordonstyp Ägare");
    print("-------------------------------");
    var vehicleList = VehicleRepository().getAll();
    for(var vehicle in vehicleList) {
      print("${vehicleList.indexOf(vehicle)} ${vehicle.printDetails}");
    }
    print("-------------------------------");
  }

}