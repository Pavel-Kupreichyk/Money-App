import 'package:money_app/models/customer.dart';

class DbService {
  Future<List<Customer>> fetchCustomers() {
    return Future.delayed(
        Duration(milliseconds: 600),
        () => [
              Customer(
                  'Антон',
                  'Антонов',
                  'Антоненко',
                  '23.04.99',
                  '123123123',
                  'МР234234',
                  'Московкий рн.',
                  '25.04.16',
                  '35252325',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  false,
                  false),
              Customer(
                  'Павел',
                  'Павлов',
                  'Павленко',
                  '13.06.89',
                  '123223123',
                  'МР244234',
                  'Мосровкий рн.',
                  '25.04.16',
                  '35252325',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  false,
                  false),
            ]);
  }
}
