import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';

class BillsBloc implements Disposable {
  final DbService _dbService;
  BillsBloc(this._dbService);

  @override
  void dispose() {}
}