import 'package:cli/models/person.dart';
import 'package:cli/repositories/repository.dart';

class PersonRepository extends Repository<Person> {

  static final PersonRepository _instance = PersonRepository._internal();
  
  PersonRepository._internal();

  factory PersonRepository() => _instance;

  void printAllPersons() {
    print("\n [Index] Id Namn Personnummer");
    print(" -------------------------------");
    var personList = PersonRepository().getAll();
    for(var person in personList) {
      print(" [${personList.indexOf(person)}] ${person.printDetails}");
    }
    print(" -------------------------------");
  }

}