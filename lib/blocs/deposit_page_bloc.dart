import 'package:money_app/models/bill.dart';
import 'package:money_app/models/customer.dart';
import 'package:money_app/models/program.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';
import 'package:rxdart/rxdart.dart';

class DepositValues {
  final List<Program> programs;
  final List<Customer> customers;

  Customer customer;
  Program program;
  String currency;
  int time;

  List<String> get programNames =>
      programs.map((p) => '${p.name} (${p.id})').toList();
  List<String> get currencies => program.percents.keys.toList();
  List<String> get times => program.time.map((v) => v.toString()).toList();
  List<String> get customerNames => customers
      .map((c) => '${c.combinedName} (${c.passportSeries}${c.passportNum})')
      .toList();
  String get customerName =>
      '${customer.combinedName} (${customer.passportSeries}${customer.passportNum})';
  String get dateOfExpire {
    var date = DateTime.now().add(Duration(days: 30 * time));
    return '${date.day}.${date.month}.${date.year}';
  }

  String get currDate {
    var date = DateTime.now();
    return '${date.day}.${date.month}.${date.year}';
  }

  String get billCode {
    var code =
        '${program.code}${customer.passportNum}${customer.billCount + 1}';
    var sum = 0;
    code.runes.forEach((rune) {
      sum += int.parse(String.fromCharCode(rune));
    });
    return '$code${sum % 10}';
  }

  String get percentCode {
    var code = '1572${customer.passportNum}${customer.billCount + 1}';
    var sum = 0;
    code.runes.forEach((rune) {
      sum += int.parse(String.fromCharCode(rune));
    });
    return '$code${sum % 10}';
  }

  double get percent => program.percents[currency] * 100;

  DepositValues(this.programs, List<Customer> customers)
      : this.customers = customers
          ..sort((s1, s2) => s1.combinedName.compareTo(s2.combinedName)) {
    selectProgram('${programs.first.name} (${programs.first.id})');
    customer = customers.first;
  }

  selectProgram(String name) {
    program = programs.firstWhere((p) => '${p.name} (${p.id})' == name);
    currency = program.percents.keys.first;
    if (program.time.isNotEmpty) {
      time = program.time.first;
    }
  }

  selectTime(String timeVal) => time = int.parse(timeVal);
  selectCustomer(String name) => customer = customers.firstWhere(
      (c) => '${c.combinedName} (${c.passportSeries}${c.passportNum})' == name);
}

class DepositBloc implements Disposable {
  final DbService _dbService;
  String depositSum = '';

  final BehaviorSubject<DepositValues> _values = BehaviorSubject();
  final BehaviorSubject<bool> _isAdding = BehaviorSubject.seeded(false);

  DepositBloc(this._dbService) {
    _fetchData();
  }

  Stream<DepositValues> get values => _values;
  Stream<bool> get isAdding => _isAdding;

  _fetchData() async {
    _values.add(DepositValues(
        await _dbService.fetchPrograms(), await _dbService.fetchCustomers()));
  }

  selectProgram(String name) {
    var value = _values.value;
    value.selectProgram(name);
    _values.add(value);
  }

  selectCurrency(String name) {
    var value = _values.value;
    value.currency = name;
    _values.add(value);
  }

  selectTime(String time) {
    var value = _values.value;
    value.selectTime(time);
    _values.add(value);
  }

  selectCustomer(String name) {
    var value = _values.value;
    value.selectCustomer(name);
    _values.add(value);
  }

  openDeposit() async {
    _isAdding.add(true);
    var mainNumber = _values.value.billCode;
    var percentNumber = _values.value.percentCode;

    var bill = Bill(
        amount: depositSum,
        actualAmount: depositSum,
        currency: _values.value.currency,
        number: mainNumber,
        owner: _values.value.customer.id,
        type: 'Пассив',
        percent: _values.value.percent * 0.01,
        percentBill: percentNumber,
        month: _values.value.time,
        isOpen: true);

    var percentBill = Bill(
        amount: '0',
        actualAmount: '0',
        currency: _values.value.currency,
        number: percentNumber,
        owner: _values.value.customer.id,
        type: 'Пассив',
        percent: 0,
        percentBill: '',
        month: _values.value.time,
        isOpen: true);

    await _dbService.addBill(bill);
    await _dbService.addBill(percentBill);
    await _dbService.incrementBillCount(_values.value.customer.id, 2);

    _isAdding.add(false);
  }

  @override
  void dispose() {
    _values.close();
    _isAdding.close();
  }
}
