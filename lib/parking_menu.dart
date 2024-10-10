import 'dart:io';
import 'package:cli/main_menu.dart' as main_menu;

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

void deleteParking() {
}

void updateParking() {
}

void getAllParkings() {
}

void getParking() {
}

void addParking() {
}
