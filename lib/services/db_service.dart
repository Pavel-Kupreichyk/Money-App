import 'package:money_app/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  Future<List<Customer>> fetchCustomers() async{
    var snapshot = await Firestore.instance
        .collection('Customers').getDocuments();
    return snapshot.documents.map((doc) => Customer.fromSnapshot(doc)).toList();
  }

  Future<void> deleteCustomer(String id) async{
    await Firestore.instance
        .collection('Customers')
        .document(id).delete();
  }

  Future<void> addCustomer(Customer customer) async{
    await Firestore.instance
        .collection('Customers')
        .document(customer.id)
        .setData({
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
  }
}
