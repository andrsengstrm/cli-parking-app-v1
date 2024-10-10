import "dart:convert";
import "dart:io";
import "package:cli/main_menu.dart" as main_menu;
import "package:cli/models/person.dart";
import "package:cli/repositories/person_repsoitory.dart";

void showMenu() {
  
  //show the submenu for 'Personer'
  print("\nMeny för personer, välj ett alternativ:"); 
  print("1. Lägg till person");
  print("2. Visa person");
  print("3. Visa alla personer");
  print("4. Uppdatera person");
  print("5. Ta bort person");
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

    addPerson();
  
  } else if(optionSelected == "2") { //list all persons
  
    getPerson();
  
  } else if(optionSelected == "3") { //list all persons
  
    getAllPersons();
  
  } else if(optionSelected == "4") { //update person
  
    updatePerson();
  
  } else if(optionSelected == "5") { //delete person
  
    deletePerson();
  
  } else if(optionSelected == "6") { //go back to main menu
  
    main_menu.showMenu();
  
  } else { //unsupported selection
  
    stdout.write("\nOgiligt val! Välj ett alternativ (1-5): ");

    readMenuSelection();
  
  }
  
}

void addPerson() {

  //ask for the name. If no name is provided, we repeat the process
  stdout.write("\nVilket namn har personen? ");
  String name = stdin.readLineSync()!;
  while(name.isEmpty) {
    stdout.write("Du måste fylla i ett namn. Vilket namn har personen? ");
    name = stdin.readLineSync()!;
  }

  //ask for personId. If no personId is provided, we repeat the process
  stdout.write("Vilket personnummer har personen? ");
  String personId = stdin.readLineSync()!;
  while(personId.isEmpty) {
    stdout.write("Du måste fylla i ett personnummer. Vilket personnummer har personen? ");
    personId = stdin.readLineSync()!;
  }
  
  try {

    //construct a Person and add Person with function from the repo
    var newPerson = Person(personId: personId, name: utf8.decode(name.codeUnits));
    PersonRepository().add(newPerson);
  
    print("\nPersonen ${newPerson.name} har lagts till.");

  } catch(err) {

    print("\nEtt fel har uppstått: $err");

  }
  
  
  showMenu();

}

void getPerson() {

  stdout.write("\nAnge index på den person du vill visa (tryck enter för att avbryta): ");
  String index = stdin.readLineSync()!;

  if(index == "") {
    showMenu();
    return;
  }

  try {
    //get the person by its id
    var person = PersonRepository().getById(int.parse(index))!;
    print("\nIndex Id Namn Personnummer");
    print("-------------------------------");
    print("$index ${person.printDetails}");
    print("-------------------------------");

    //print(" [${person.personId}] ${person.name}");

    showMenu();

  } on StateError { //no one was found, lets try again

    print("Det finns ingen person med index $index");
    getPerson();

  } on RangeError { //outside the index, lets try again

    print("Det finns ingen person med index $index");
    getPerson();

  } catch(err) { //some other error

    print("\nEtt fel har uppstått: $err");
    getPerson();

  }
  
}

void getAllPersons() {

  //get all persons from the repo
  var personList = PersonRepository().getAll();

  if(personList.isEmpty) {
    
    print("\nDet finns inga personer registrerade");
  
  } else {
    
    //print all persons by using a function in the repo
    PersonRepository().printAllPersons();

  }

  showMenu();

}

void updatePerson() {

  stdout.write("\nAnge index på den person du vill uppdatera (tryck enter för att avbryta): ");
  String index = stdin.readLineSync()!;

  if(index == "") {
    showMenu();
    return;
  }


  try {

    //try to get the person from the personrepository
    var person = PersonRepository().getById(int.parse(index))!;

    //ask to update the name
    stdout.write("\nUppdatera namn (${person.name}): ");
    String name = stdin.readLineSync()!;
    name = name.isNotEmpty ? utf8.decode(name.codeUnits) : person.name;

    //ask to update the personId
    stdout.write("Uppdatera personnummer (${person.personId}): ");
    String personId = stdin.readLineSync()!;
    personId = personId.isNotEmpty ? personId : person.personId;

    var updatedPerson = Person(personId: personId, name: name);

    //update the person
    person = PersonRepository().update(person, updatedPerson)!;
    print("\nPersonen har uppdaterats");

  } on StateError { //no one was found, lets try again

    print("Det finns ingen person med index $index");
    updatePerson();

  } on RangeError { //outside the index, lets try again

    print("Det finns ingen person med index $index");
    updatePerson();

  } catch(err) { //some other error

    print("Ett fel har uppstått: $err");

  }

  showMenu();

}

void deletePerson() {

  //get all persons, if empty we return to the menu
  var personList = PersonRepository().getAll();
  if(personList.isEmpty) {
    showMenu();
    return;
  }

  stdout.write("\nAnge index på den person du vill ta bort (tryck enter för att avbryta): ");
  String index = stdin.readLineSync()!;

  if(index == "") { //no value provided
    showMenu();
    return;
  }

  try {
    //try to get the person from the personrepository
    Person person = PersonRepository().getById(int.parse(index))!;

    //delete the person
    PersonRepository().delete(person);
    print("Personen ${person.name} har tagits bort");

  } on StateError { //no one was found, lets try again

    print("Det finns ingen person med index $index");
    deletePerson();

  } on RangeError { //outside the index, lets try again

    print("Det finns ingen person med index $index");
    deletePerson();

  } catch(err) { //some other error

    print("Ett fel har uppstått: $err");

  }

  showMenu();

}