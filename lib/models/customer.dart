import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dateOfBirth;
  final String passportSeries;
  final String passportNum;
  final String passportEmitter;
  final DateTime passportDateOfEmit;
  final String id;
  final String placeOfBirth;
  final String city;
  final String address;
  final String mobilePhoneNumber;
  final String homePhoneNumber;
  final String email;
  final String workPlace;
  final String workPosition;
  final String familyStatus;
  final String citizenship;
  final String disabilityStatus;
  final String monthlyIncome;
  final bool isPensioner;
  final bool isDutyBound;

  Customer(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.dateOfBirth,
      this.passportSeries,
      this.passportNum,
      this.passportEmitter,
      this.passportDateOfEmit,
      this.id,
      this.placeOfBirth,
      this.city,
      this.address,
      this.mobilePhoneNumber,
      this.homePhoneNumber,
      this.email,
      this.workPlace,
      this.workPosition,
      this.familyStatus,
      this.citizenship,
      this.disabilityStatus,
      this.monthlyIncome,
      this.isPensioner,
      this.isDutyBound});

  factory Customer.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) {
      return null;
    }
    return Customer(
        firstName: snapshot['firstName'],
        middleName: snapshot['middleName'],
        lastName: snapshot['lastName'],
        dateOfBirth: (snapshot['dateOfBirth'] as Timestamp)?.toDate(),
        passportSeries: snapshot['passportSeries'],
        passportNum: snapshot['passportNum'],
        passportEmitter: snapshot['passportEmitter'],
        passportDateOfEmit:
            (snapshot['passportDateOfEmit'] as Timestamp)?.toDate(),
        id: snapshot['id'],
        placeOfBirth: snapshot['placeOfBirth'],
        city: snapshot['city'],
        address: snapshot['address'],
        mobilePhoneNumber: snapshot['mobilePhoneNumber'],
        homePhoneNumber: snapshot['homePhoneNumber'],
        email: snapshot['email'],
        workPlace: snapshot['workPlace'],
        workPosition: snapshot['workPosition'],
        familyStatus: snapshot['familyStatus'],
        citizenship: snapshot['citizenship'],
        disabilityStatus: snapshot['disabilityStatus'],
        monthlyIncome: snapshot['monthlyIncome'],
        isPensioner: snapshot['isPensioner'],
        isDutyBound: snapshot['isDutyBound']);
  }
}
