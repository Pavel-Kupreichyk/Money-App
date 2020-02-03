import 'package:money_app/models/customer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc implements Disposable {
  final PublishSubject<List<Customer>> _customers = PublishSubject();
  final DbService _dbService;

  MainBloc(this._dbService) {
    updateCustomers();
  }

  Stream<List<Customer>> get customers => _customers;

  Future updateCustomers() async {
    _customers.add(await _dbService.fetchCustomers());
  }

  @override
  void dispose() {
    _customers.close();
  }
}
