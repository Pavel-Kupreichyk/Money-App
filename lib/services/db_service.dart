import 'package:money_app/models/customer.dart';

class DbService {
  Future<List<Customer>> fetchCustomers() {
    return Future.delayed(
        Duration(milliseconds: 600),
        () => [
              Customer(
                  firstName: 'Антон',
                  middleName: 'Антонович',
                  lastName: 'Антоненко',
                  dateOfBirth: '23.04.99',
                  city: 'Минск',
                  address: 'ул.Платонова д.4'),
              Customer(
                  firstName: 'Павел',
                  middleName: 'Павлов',
                  lastName: 'Павленко',
                  dateOfBirth: '13.06.89',
                  city: 'Брест',
                  address: 'ул.Менделеева д.40')
            ]);
  }
}
