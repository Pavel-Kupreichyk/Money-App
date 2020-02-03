import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';

class EditCustomerBloc implements Disposable {
  final DbService _dbService;
  EditCustomerBloc(this._dbService);

  @override
  void dispose() {}
}