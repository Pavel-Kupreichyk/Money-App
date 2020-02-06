import 'package:money_app/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  CollectionReference get customers =>
      Firestore.instance.collection('Customers');
  CollectionReference get passports =>
      Firestore.instance.collection('Passports');

  Future<List<Customer>> fetchCustomers() async {
    var snapshot = await customers.getDocuments();
    return snapshot.documents.map((doc) => Customer.fromSnapshot(doc)).toList();
  }

  Future<void> deleteCustomer(String id) async {
    await customers.document(id).delete();
  }

  Future<void> deletePassport(String series, String num) async {
    await passports.document(series + num).delete();
  }

  Future<bool> isPassportIdExists(String id) async {
    var doc = await customers.document(id).get();
    return doc.exists;
  }

  Future<bool> isPassportExists(String series, String num) async {
    var doc = await passports.document(series + num).get();
    return doc.exists;
  }

  Future<void> addCustomer(Customer customer) async {
    await customers.document(customer.id).setData({
      'firstName': customer.firstName,
      'middleName': customer.middleName,
      'lastName': customer.lastName,
      'dateOfBirth': customer.dateOfBirth,
      'passportSeries': customer.passportSeries,
      'passportNum': customer.passportNum,
      'passportEmitter': customer.passportEmitter,
      'passportDateOfEmit': customer.passportDateOfEmit,
      'id': customer.id,
      'placeOfBirth': customer.placeOfBirth,
      'city': customer.city,
      'address': customer.address,
      'mobilePhoneNumber': customer.mobilePhoneNumber,
      'homePhoneNumber': customer.homePhoneNumber,
      'email': customer.email,
      'workPlace': customer.workPlace,
      'workPosition': customer.workPosition,
      'familyStatus': customer.familyStatus,
      'citizenship': customer.citizenship,
      'disabilityStatus': customer.disabilityStatus,
      'monthlyIncome': customer.monthlyIncome,
      'isPensioner': customer.isPensioner,
      'isDutyBound': customer.isDutyBound
    });

    await passports
        .document(customer.passportSeries + customer.passportNum)
        .setData({
      'passportSeries': customer.passportSeries,
      'passportNum': customer.passportNum,
      'passportEmitter': customer.passportEmitter,
      'passportDateOfEmit': customer.passportDateOfEmit,
      'id': customer.id,
      'placeOfBirth': customer.placeOfBirth,
      'city': customer.city,
      'address': customer.address,
    });
  }
}
