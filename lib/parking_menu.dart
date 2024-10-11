import "dart:io";
import "package:cli/main_menu.dart" as main_menu;
import "package:cli/models/parking.dart";
import "package:cli/repositories/parking_repository.dart";
import "package:cli/models/vehicle.dart";
import "package:cli/vehicle_menu.dart" as vehicle_menu;
import "package:cli/repositories/vehicle_repository.dart";
import "package:cli/parking_space_menu.dart" as parking_space_menu;
import "package:cli/models/parking_space.dart";
import "package:cli/repositories/parking_space_repository.dart";

void showMenu() {
  
  //show the submenu for 'Personer'
  print("\nMeny för parkingar, välj ett alternativ:"); 
  print("1. Lägg till parkering");
  print("2. Visa parkering");
  print("3. Visa alla parkeringar");
  print("4. Uppdatera parkering");
  print("5. Ta bort parkering");
  print("6. Gå tillbaka till huvudmenyn");
  stdout.write("\nVälj ett alternativ (1-6): ");

  //read the selected option
  readMenuSelection();

}

void readMenuSelection() {
  
  //wait for input and read the selection option
  String optionSelected = stdin.readLineSync()!;

  //select action based on the selected option
  if(optionSelected == "1") { 
    
    //add parking
    addParking();
  
  } else if(optionSelected == "2") { 
    
    //list parking
    getParking();
  
  } else if(optionSelected == "3") { 
    
    //list all parkings
    getAllParkings();
  
  } else if(optionSelected == "4") { 
    
    //update parking
    updateParking();
  
  } else if(optionSelected == "5") { 

    //delete parking
    deleteParking();
  
  } else if(optionSelected == "6") { 

    //go back to main menu
    main_menu.showMenu();
  
  } else { 
    
    //unsupported selection
    stdout.write("\nOgiligt val! Välj ett alternativ (1-5): ");

    readMenuSelection();
  
  }
  
}

void addParking() {

  //set the vehicle
  Vehicle vehicle = setVehicle();

  //set the parkingspace
  ParkingSpace parkingSpace = setParkingSpace();

  //set the starttime
  double startTime = setTime(message: "\nVilken tid ska parkeringen börja?");

  //set the endtime
  double endTime = setTime(message: "\nVilken tid ska parkeringen sluta?");

  try {

    //set the parking-object
    Parking newParking = Parking(vehicle: vehicle, parkingSpace: parkingSpace, startTime: startTime, endTime: endTime);
    ParkingRepository().add(newParking);

    print("\nParkeringen har startats.");

  } catch(err) {

    print("\nEtt fel har uppstått: $err");

  }

  showMenu();


}

void getParking() {
}

void getAllParkings() {
}

void updateParking() {
}

void deleteParking() {
}


/*---------------- subfunctions ----------------*/

//set the vehicle
Vehicle setVehicle([String message = "\nVilket fordon vill du parkera?"]) {

  print(message);

  //list all vehicles
  var vehicleList = VehicleRepository().getAll();
  vehicle_menu.printVehicleList(vehicleList);

  //ask for index
  String inputVehicleIndex;
  do {
    stdout.write("Välj fordonets index: ");
    inputVehicleIndex = stdin.readLineSync()!;
  } while(inputVehicleIndex.isEmpty || int.tryParse(inputVehicleIndex) == null || int.tryParse(inputVehicleIndex)! >= vehicleList.length);

  //select the item by index and return it
  return VehicleRepository().getById(int.parse(inputVehicleIndex))!;

}

//set the parkingspace
ParkingSpace setParkingSpace([String message = "\nVilken perkeringsplats vill du använda?"]) {

  print(message);

  //list all parkingspaces
  var parkingSpaceList = ParkingSpaceRepository().getAll();
  parking_space_menu.printParkingSpaceList(parkingSpaceList);

  //ask for index
  String inputParkingSpaceIndex;
  do {
    stdout.write("Välj parkeringsplatsens index: ");
    inputParkingSpaceIndex = stdin.readLineSync()!;
  } while(inputParkingSpaceIndex.isEmpty || int.tryParse(inputParkingSpaceIndex) == null || int.tryParse(inputParkingSpaceIndex)! >= parkingSpaceList.length);

  //select the item by index and return it
  return ParkingSpaceRepository().getById(int.parse(inputParkingSpaceIndex))!;

}

double setTime({required String message}) {

  print(message);

  //set the time
  String inputTime;
  do {
    stdout.write("Fyll i klockslag (HH.MM): ");
    inputTime = stdin.readLineSync()!;

  } while(double.tryParse(inputTime) == null);

  return double.parse(inputTime);

}









