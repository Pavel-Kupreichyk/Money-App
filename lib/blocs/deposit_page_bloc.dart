import 'package:money_app/models/customer.dart';
import 'package:money_app/models/program.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';
import 'package:rxdart/rxdart.dart';

class DepositValues {
  final List<Program> programs;
  Program program;
  String currency;
  int time;

  List<String> get programNames => programs.map((p) => p.name).toList();
  List<String> get currencies => program.percents.keys.toList();
  List<String> get times => program.time.map((v) => v.toString()).toList();
  double get percent => program.percents[currency] * 100;

  DepositValues(this.programs) {
    selectProgram(programs.first.name);
  }

  selectProgram(String name) {
    program = programs.firstWhere((p) => p.name == name);
    currency = program.percents.keys.first;
    if (program.time.isNotEmpty) {
      time = program.time.first;
    }
  }

  selectTime(String timeVal) => time = int.parse(timeVal);
}

class DepositBloc implements Disposable {
  Customer customer;
  final DbService _dbService;

  BehaviorSubject<DepositValues> _values = BehaviorSubject();

  DepositBloc(this._dbService) {
    _dbService.fetchPrograms().then((val) => _values.add(DepositValues(val)));
  }

  Stream<DepositValues> get values => _values;

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

  @override
  void dispose() {
    _values.close();
  }
}
