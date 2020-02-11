import 'package:money_app/models/bill.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';
import 'package:rxdart/rxdart.dart';

class BillsBloc implements Disposable {
  final DbService _dbService;

  final BehaviorSubject<List<Bill>> _bills = BehaviorSubject();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);

  BillsBloc(this._dbService) {
    fetchBills();
  }

  Stream<List<Bill>> get bills => _bills;
  Stream<bool> get isLoading => _isLoading;

  fetchBills() async {
    if (_isLoading.value) {
      return;
    }
    _isLoading.add(true);
    _bills.add(await _dbService.fetchBills());
    _isLoading.add(false);
  }

  closeBill(String number) async {
    if (_isLoading.value) {
      return;
    }
    _isLoading.add(true);
    await _dbService.closeBill(number);
    _bills.add(await _dbService.fetchBills());
    _isLoading.add(false);
  }

  closeDay() async {
    if (_isLoading.value) {
      return;
    }

    _isLoading.add(true);

    _isLoading.add(false);
  }

  @override
  void dispose() {
    _isLoading.close();
    _bills.close();
  }
}
