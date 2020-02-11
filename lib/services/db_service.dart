import 'package:money_app/models/bill.dart';
import 'package:money_app/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/models/program.dart';
import 'package:money_app/models/value_list.dart';

class DbService {
  CollectionReference get customers =>
      Firestore.instance.collection('Customers');
  CollectionReference get passports =>
      Firestore.instance.collection('Passports');
  CollectionReference get valueLists => Firestore.instance.collection('Lists');
  CollectionReference get programs => Firestore.instance.collection('Programs');
  CollectionReference get bills => Firestore.instance.collection('Bills');

  Future<List<Customer>> fetchCustomers() async {
    var snapshot = await customers.getDocuments();
    return snapshot.documents.map((doc) => Customer.fromSnapshot(doc)).toList();
  }

  Future<List<Program>> fetchPrograms() async {
    var snapshot = await programs.getDocuments();
    return snapshot.documents.map((doc) => Program.fromSnapshot(doc)).toList();
  }

  Future<List<Bill>> fetchBills() async {
    var snapshot = await bills.getDocuments();
    return snapshot.documents.map((doc) => Bill.fromSnapshot(doc)).toList();
  }

  Future<List<ValueList>> fetchLists() async {
    var snapshot = await valueLists.getDocuments();
    return snapshot.documents
        .map((doc) => ValueList.fromSnapshot(doc))
        .toList();
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

  Future<void> addBill(Bill bill) async {
    await bills.document(bill.number).setData({
      'amount': bill.amount,
      'actualAmount': bill.actualAmount,
      'currency': bill.currency,
      'number': bill.number,
      'owner': bill.owner,
      'type': bill.type,
      'percent': bill.percent,
      'percentBill': bill.percentBill,
      'isOpen': bill.isOpen,
      'month': bill.month,
    });
  }

  Future<void> closeBill(String number) async {
    await bills.document(number).updateData({'isOpen': false});
  }

  Future<void> changeBillAmount(String number, double value) async {
    await bills
        .document(number)
        .updateData({'actualAmount': FieldValue.increment(value)});
  }

  Future<void> incrementBillCount(String id, int val) async => await customers
      .document(id)
      .updateData({'billCount': FieldValue.increment(val)});

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
      'isDutyBound': customer.isDutyBound,
      'billCount': customer.billCount,
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
