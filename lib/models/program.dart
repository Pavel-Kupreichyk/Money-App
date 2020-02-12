import 'package:cloud_firestore/cloud_firestore.dart';

class Program {
  final String name;
  final String id;
  final String type;
  final String code;
  final Map<String, double> percents;
  final List<int> time;

  Program({this.id, this.name, this.type, this.percents, this.time, this.code});

  factory Program.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) {
      return null;
    }
    return Program(
        name: snapshot['name'],
        id: snapshot['id'],
        type: snapshot['type'],
        code: snapshot['code'],
        percents: snapshot['percents']?.cast<String, double>(),
        time: snapshot['time']?.cast<int>() ?? []);
  }
}
