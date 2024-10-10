import "dart:convert";
import "dart:io";
import "package:cli/main_menu.dart" as main_menu;
import "package:cli/models/person.dart";
import "package:cli/models/vehicle.dart";
import "package:cli/repositories/person_repsoitory.dart";
import "package:cli/repositories/vehicle_repository.dart";

void showMenu() {
  
  //show the submenu for 'Personer'
  print("\nMeny för fordon, välj ett alternativ:"); 
  print("1. Registrera nytt fordon");
  print("2. Visa fordon");
  print("3. Visa alla fordon");
  print("4. Uppdatera fordon");
  print("5. Ta bort fordon");
  print("6. Gå tillbaka till huvudmenyn");
  stdout.write("\nVälj ett alternativ (1-6): ");

  //read the selected option
  readMenuSelection();

}

void readMenuSelection() {
  
  //wait for input and read the selection option
  String optionSelected = stdin.readLineSync()!;

  //select action based on the selected option
  if(optionSelected == "1") { //add person

    addVehicle();
  
  } else if(optionSelected == "2") { //list all persons
  
    getVehicle();
  
  } else if(optionSelected == "3") { //list all persons
  
    getAllVehicles();
  
  } else if(optionSelected == "4") { //update person
  
    updateVehicle();
  
  } else if(optionSelected == "5") { //delete person
  
    deleteVehicle();
  
  } else if(optionSelected == "6") { //go back to main menu
  
    main_menu.showMenu();
  
  } else { //unsupported selection
  
    stdout.write("\nOgiligt val! Välj ett alternativ (1-5): ");

    readMenuSelection();
  
  }
  
}

void addVehicle() {

  //ask for the regId. If no regId is provided, we repeat the process
  stdout.write("\nVilket registreringsnummer har fordonet? ");
  String regId = stdin.readLineSync()!;
  while(regId.isEmpty) { // we loop this until we get a value
    stdout.write("Du måste fylla i ett registreringsnummer. Vilket registreringsnummer har fordonet? ");
    regId = stdin.readLineSync()!;
  }

  //ask for vehicletype
  print("Vilken typ av fordon är det?");
  var vehicleTypes = VehicleType.values;
  String typeSelection = "";
  for(var type in vehicleTypes) {
    typeSelection += "${vehicleTypes.indexOf(type)} - ${type.name.toUpperCase()}, ";
  }
  print(typeSelection);
  stdout.write("Välj fordonstyp: ");
  int typeIndex = int.tryParse(stdin.readLineSync()!)!;
  while(typeIndex >= vehicleTypes.length) {
    stdout.write("Välj fordonstyp: ");
    typeIndex = int.tryParse(stdin.readLineSync()!)!;
  }
  var vehicleType = VehicleType.values[typeIndex];

  //print all persons so the user can select the owner the person-index
  print("Vem är ägaren av fordonet?");
  PersonRepository().printAllPersons();
  stdout.write("\nVälj personens index: ");
  String ownerIndex = stdin.readLineSync()!;
  var ownerPerson = PersonRepository().getById(int.tryParse(ownerIndex)!)!;

  try {

    //construct a Person and add Person with function from the repo
    var newVehicle = Vehicle(regId: regId, vehicleType: vehicleType, owner: ownerPerson);
    VehicleRepository().add(newVehicle);

    print("\nFordonet med regstreringsnummer ${newVehicle.regId} har lagts till.");

  } catch(err) {

    print("\nEtt fel har uppstått: $err");

  }
  
  
  showMenu();

}

void getVehicle() {

  stdout.write("\nAnge index på det fordon du vill visa (tryck enter för att avbryta): ");
  String index = stdin.readLineSync()!;

  if(index == "") {
    showMenu();
    return;
  }

  try {
    //get the vehicle by its id
    var vehicle = VehicleRepository().getById(int.parse(index))!;
    print("\n [Index] Id Regnr Fordonstyp Ägare");
    print(" -------------------------------");
    print(" [$index] ${vehicle.printDetails}");
    print(" -------------------------------");


    showMenu();

  } on StateError { //no one was found, lets try again

    print("Det finns inget fordon med index $index");
    getVehicle();

  } on RangeError { //outside the index, lets try again

    print("Det finns inget fordon med index $index");
    getVehicle();

  } catch(err) { //some other error

    print("\nEtt fel har uppstått: $err");
    getVehicle();

  }
  
}

void getAllVehicles() {

  //get all persons from the repo
  var vehicleList = VehicleRepository().getAll();

  if(vehicleList.isEmpty) {
    
    print("\nDet finns inga fordon registrerade");
  
  } else {
    
    VehicleRepository().printAllVehicles();

  }

  showMenu();

}

void updateVehicle() {

  stdout.write("\nAnge index på det fordon du vill uppdatera (tryck enter för att avbryta): ");
  String index = stdin.readLineSync()!;

  if(index == "") {
    showMenu();
    return;
  }

  try {

    //try to get the vehicle from the personrepository
    var vehicle = VehicleRepository().getById(int.parse(index))!;

    //ask to update the name
    stdout.write("Uppdatera registreringsnummer (${vehicle.regId}): ");
    String regId = stdin.readLineSync()!;
    regId = regId.isNotEmpty ? regId : vehicle.regId;

    print("Uppdatera fordonstyp");
    var vehicleTypes = VehicleType.values;
    String typeSelection = "";
    for(var type in vehicleTypes) {
      typeSelection += "${vehicleTypes.indexOf(type)} - ${type.name.toUpperCase()}, ";
    }
    print(typeSelection);
    stdout.write("Välj fordonstyp: ");
    int typeIndex = int.tryParse(stdin.readLineSync()!)!;
    while(typeIndex >= vehicleTypes.length) {
      stdout.write("Välj fordonstyp: ");
      typeIndex = int.tryParse(stdin.readLineSync()!)!;
    }
    var vehicleType = VehicleType.values[typeIndex];

      //print all persons so the user can select the owner the person-index
    print("Uppdatera ägaren av fordonet");
    PersonRepository().printAllPersons();
    stdout.write("\nVälj personens index: ");
    String ownerIndex = stdin.readLineSync()!;
    var ownerPerson = PersonRepository().getById(int.tryParse(ownerIndex)!)!;

    var updatedVehicle = Vehicle(regId: regId, vehicleType: vehicleType, owner: ownerPerson );

    //update the person
    vehicle = VehicleRepository().update(vehicle, updatedVehicle)!;
    print("Fordonet har uppdaterats");

  } on StateError { //no one was found, lets try again

    print("Det finns inget fordon med index $index");
    updateVehicle();

  } on RangeError { //outside the index, lets try again

    print("Det finns inget fordon med index $index");
    updateVehicle();

  } catch(err) { //some other error

    print("Ett fel har uppstått: $err");

  }

  showMenu();

}

void deleteVehicle() {

  //get all persons, if empty we return to the menu
  var vehicleList = VehicleRepository();

  if(vehicleList.getAll().isEmpty) {
    showMenu();
    return;
  }

  stdout.write("\nAnge index på det fordon som du vill ta bort (tryck enter för att avbryta): ");
  String index = stdin.readLineSync()!;

  if(index == "") { //no value provided
    showMenu();
    return;
  }

  try {
    //try to get the person from the personrepository
    Vehicle vehicle = vehicleList.getById(int.parse(index))!;

    //delete the person
    vehicleList.delete(vehicle);
    print("Fordonet med registreringsnummer ${vehicle.regId} har tagits bort");

  } on StateError { //no one was found, lets try again

    print("Det finns inget fordon med index $index");
    deleteVehicle();

  } on RangeError { //outside the index, lets try again

    print("Det finns inget forodn med index $index");
    deleteVehicle();

  } catch(err) { //some other error

    print("Ett fel har uppstått: $err");

  }

  showMenu();

}