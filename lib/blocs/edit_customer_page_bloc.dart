import 'package:money_app/models/customer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';

class EditCustomerBloc implements Disposable {
  final DbService _dbService;
  final Customer currCustomer;
  bool get hasCustomer => currCustomer != null;

  EditCustomerBloc(this._dbService, {this.currCustomer});

  @override
  void dispose() {}
}