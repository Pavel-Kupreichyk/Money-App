import 'package:money_app/models/bill.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/courses.dart';
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
    var main = _bills.value.firstWhere((b) => b.owner == 'СФРБ');
    var bill = _bills.value.firstWhere((b) => b.number == number);
    await _dbService.changeBill(
      bill.number,
      mainAmount: bill.actualAmount,
      isOpen: false,
    );

    await _dbService.changeBill(main.number,
        mainAmount: -1 * _convertToBYN(bill.actualAmount, bill.currency));
    _bills.add(await _dbService.fetchBills());
    _isLoading.add(false);
  }

  closeDay() async {
    if (_isLoading.value) {
      return;
    }

    _isLoading.add(true);
    var main = _bills.value.firstWhere((b) => b.owner == 'СФРБ');
    var cash = _bills.value.firstWhere((b) => b.owner == 'Касса');
    var bills = _bills.value.where((b) => b != main && b != cash);
    for (var bill in bills) {
      if (bill.isOpen && bill.percentBill != null) {
        var sum = bill.amount * bill.percentBill.percent / 12;
        if (bill.month > 1) {
          await _dbService.changeBill(
            bill.number,
            percentBill: bill.percentBill,
            month: -1,
            potentialAmount: sum,
          );
        } else if (bill.month == 1) {
          await _dbService.changeBill(
            bill.number,
            percentBill: bill.percentBill,
            potentialAmount: -1 * bill.percentBill.potentialAmount,
            percentAmount: sum + bill.percentBill.potentialAmount,
            month: -1,
            mainAmount: bill.actualAmount,
            isOpen: false,
          );
          await _dbService.changeBill(main.number,
              mainAmount: -1 *
                  _convertToBYN(
                      bill.actualAmount +
                          sum +
                          bill.percentBill.potentialAmount,
                      bill.currency));
        } else if (bill.month == -1) {
          await _dbService.changeBill(bill.number,
              percentBill: bill.percentBill, percentAmount: sum);
          await _dbService.changeBill(main.number,
              mainAmount: -1 * _convertToBYN(sum, bill.currency));
        }
      }
    }
    _bills.add(await _dbService.fetchBills());
    _isLoading.add(false);
  }

  double _convertToBYN(double sum, String currency) {
    switch (currency) {
      case 'USD':
        return sum * Courses.usd_byn;
      case 'RUB':
        return sum * Courses.rub_byn;
      case 'EUR':
        return sum * Courses.eur_byn;
      default:
        return sum;
    }
  }

  @override
  void dispose() {
    _isLoading.close();
    _bills.close();
  }
}
