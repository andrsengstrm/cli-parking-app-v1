import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Person {
  String id;
  String personId;
  String name;

  Person({String? id, required this.personId, required this.name }) : id = id ?? uuid.v1();

  String get printDetails => "$id $name $personId";
 
}