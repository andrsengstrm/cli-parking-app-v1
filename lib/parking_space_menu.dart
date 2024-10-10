import 'dart:io';
import 'package:cli/main_menu.dart' as main_menu;

void showMenu() {
  
  //show the submenu for 'Personer'
  print("\nMeny för parkingsplatser, välj ett alternativ:"); 
  print("1. Lägg till parkeringsplats");
  print("2. Visa parkeringsplats");
  print("3. Visa alla parkeringsplats");
  print("4. Uppdatera parkeringsplats");
  print("5. Ta bort parkeringsplats");
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
    
    //add parkingspace
    addParkingSpace();
  
  } else if(optionSelected == "2") { 
    
    //list parkingspace
    getParkingSpace();
  
  } else if(optionSelected == "3") { 
    
    //list all parkingspaces
    getAllParkingSpaces();
  
  } else if(optionSelected == "4") { 
    
    //update parkingspace
    updateParkingSpace();
  
  } else if(optionSelected == "5") { 
    
    //delete parkingspace
    deleteParkingSpace();
  
  } else if(optionSelected == "6") { 
    
    //go back to main menu
    main_menu.showMenu();
  
  } else { 
    
    //unsupported selection
    stdout.write("\nOgiligt val! Välj ett alternativ (1-5): ");

    readMenuSelection();
  
  }
  
}

void addParkingSpace() {



}

void getParkingSpace() {



}

void getAllParkingSpaces() {



}

void updateParkingSpace() {



}

void deleteParkingSpace() {



}








