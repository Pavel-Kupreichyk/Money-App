import 'package:cloud_firestore/cloud_firestore.dart';

class ValueList {
  final String name;
  final List<String> values;

  ValueList({this.name, this.values});

  factory ValueList.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) {
      return null;
    }
    return ValueList(
        name: snapshot['name'], values: snapshot['values'].cast<String>());
  }
}
