import 'package:cli/models/parking_space.dart';
import 'package:cli/models/vehicle.dart';
import 'package:cli/repositories/parking_space_repository.dart';
import 'package:cli/repositories/vehicle_repository.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Parking {
  final String id;
  final String vehicleId;
  final String parkingSpaceId;
  final DateTime startTime;
  DateTime? endTime;

  Parking({String? id, required this.vehicleId, required this.parkingSpaceId, required this.startTime, this.endTime}) : id = id ?? uuid.v1();

  String get printDetails => "$id ${VehicleRepository().getVehicleById(vehicleId).regId} ${ParkingSpaceRepository().getParkingSpaceById(parkingSpaceId).address} $startTime $endTime ${getCostForParking()}";

  //calculate the price for the parking
  String getCostForParking() {
    
    double cost = 0;
    
    //caclulate differnce in milliseconds from epoch. If parking is not finished we use now() to get the current cost
    int start = startTime.millisecondsSinceEpoch;
    int end = endTime?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch;
    int total = end - start;

    //convert to hours and calculate the cost
    double totalHours = total / 3600000;
    cost =  totalHours * ParkingSpaceRepository().getParkingSpaceById(parkingSpaceId).pricePerHour;

    return cost.toStringAsFixed(2);

  }

}