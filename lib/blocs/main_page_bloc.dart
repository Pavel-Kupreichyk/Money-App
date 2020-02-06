import 'package:money_app/models/customer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/services/navigation_service.dart';
import 'package:money_app/support/disposable.dart';
import 'package:money_app/support/navigation_info.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc implements Disposable {
  final BehaviorSubject<List<Customer>> _customers = BehaviorSubject();
  final DbService _dbService;
  final NavigationService _navigationService;

  MainBloc(this._dbService, this._navigationService) {
    updateCustomers();
  }

  Stream<List<Customer>> get customers => _customers;

  Future updateCustomers() async {
    _customers.add(await _dbService.fetchCustomers());
  }

  editCustomer(int id) {
    _navigationService.pushReplacementWithNavInfo(
        NavigationInfo.editCustomer(_customers.value[id]));
  }

  @override
  void dispose() {
    _customers.close();
  }
}
