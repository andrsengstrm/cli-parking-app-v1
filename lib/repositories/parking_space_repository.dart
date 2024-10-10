import 'package:cli/models/parking_space.dart';
import 'package:cli/repositories/repository.dart';

class ParkingSpaceRepository extends Repository<ParkingSpace> {

  static final ParkingSpaceRepository _instance = ParkingSpaceRepository._internal();

  ParkingSpaceRepository._internal();

  factory ParkingSpaceRepository() => _instance;

  void printAllParkingSpaces() {
    print("\nIndex Id Adress Pris/timme");
    print("-------------------------------");
    var parkingSpaceList = ParkingSpaceRepository().getAll();
    for(var parkingSpace in parkingSpaceList) {
      print("${parkingSpaceList.indexOf(parkingSpace)} ${parkingSpace.printDetails}");
    }
    print("-------------------------------");
  }


}