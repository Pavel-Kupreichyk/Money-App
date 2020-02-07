import 'package:money_app/models/customer.dart';
import 'package:money_app/models/value_list.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';
import 'package:rxdart/rxdart.dart';

enum Status { ok, idExists, passportExists }

class EditCustomerBloc implements Disposable {
  String firstName = '';
  String middleName = '';
  String lastName = '';
  DateTime dateOfBirth = DateTime.now();
  String passportSeries = '';
  String passportNum = '';
  String passportEmitter = '';
  DateTime passportDateOfEmit = DateTime.now();
  String id = '';
  String placeOfBirth = '';
  String city = 'Минск';
  String address = '';
  String mobilePhoneNumber = '';
  String homePhoneNumber = '';
  String email = '';
  String workPlace = '';
  String workPosition = '';
  String familyStatus = 'Свободен/Свободна';
  String citizenship = 'Беларусь';
  String disabilityStatus = 'Нет';
  String monthlyIncome = '';
  bool isPensioner = false;
  bool isDutyBound = false;

  final DbService _dbService;
  final Customer _currCustomer;
  final BehaviorSubject<List<ValueList>> _valueLists = BehaviorSubject();
  String get btnName => _currCustomer == null ? 'Добавить' : 'Изменить';

  EditCustomerBloc(this._dbService, [this._currCustomer]) {
    _dbService.fetchLists().then((lists) => _valueLists.add(lists));
    if (_currCustomer != null) {
      dateOfBirth = _currCustomer.dateOfBirth ?? DateTime.now();
      passportDateOfEmit = _currCustomer.passportDateOfEmit ?? DateTime.now();
      firstName = _currCustomer.firstName ?? '';
      middleName = _currCustomer.middleName ?? '';
      lastName = _currCustomer.lastName ?? '';
      passportSeries = _currCustomer.passportSeries ?? '';
      passportNum = _currCustomer.passportNum ?? '';
      passportEmitter = _currCustomer.passportEmitter ?? '';
      id = _currCustomer.id ?? '';
      placeOfBirth = _currCustomer.placeOfBirth ?? '';
      city = _currCustomer.city ?? 'Минск';
      address = _currCustomer.address ?? '';
      mobilePhoneNumber = _currCustomer.mobilePhoneNumber ?? '';
      homePhoneNumber = _currCustomer.homePhoneNumber ?? '';
      email = _currCustomer.email ?? '';
      workPlace = _currCustomer.workPlace ?? '';
      workPosition = _currCustomer.workPosition ?? '';
      familyStatus = _currCustomer.familyStatus ?? 'Свободен/Свободна';
      citizenship = _currCustomer.citizenship ?? 'Беларусь';
      disabilityStatus = _currCustomer.disabilityStatus ?? 'Нет';
      monthlyIncome = _currCustomer.monthlyIncome ?? '';
      isPensioner = _currCustomer.isPensioner ?? false;
      isDutyBound = _currCustomer.isDutyBound ?? false;
    }
  }

  Stream<List<ValueList>> get valueLists => _valueLists;

  Future<Status> addEditCustomer() async {
    if (_currCustomer != null) {
      bool deleteId = false;
      bool deleteNum = false;
      if (_currCustomer.id != id) {
        if (await _dbService.isPassportIdExists(id)) {
          return Status.idExists;
        }
        deleteId = true;
      }
      if (_currCustomer.passportSeries + _currCustomer.passportNum !=
          passportSeries + passportNum) {
        if (await _dbService.isPassportExists(passportSeries, passportNum)) {
          return Status.passportExists;
        }
        deleteNum = true;
      }
      if (deleteId) await _dbService.deleteCustomer(_currCustomer.id);
      if (deleteNum)
        await _dbService.deletePassport(
            _currCustomer.passportSeries, _currCustomer.passportNum);
    } else {
      if (await _dbService.isPassportIdExists(id)) {
        return Status.idExists;
      }
      if (await _dbService.isPassportExists(passportSeries, passportNum)) {
        return Status.passportExists;
      }
    }
    var newCustomer = Customer(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        passportSeries: passportSeries,
        passportNum: passportNum,
        passportEmitter: passportEmitter,
        passportDateOfEmit: passportDateOfEmit,
        id: id,
        placeOfBirth: placeOfBirth,
        city: city,
        address: address,
        mobilePhoneNumber: mobilePhoneNumber,
        homePhoneNumber: homePhoneNumber,
        email: email,
        workPlace: workPlace,
        workPosition: workPosition,
        familyStatus: familyStatus,
        citizenship: citizenship,
        disabilityStatus: disabilityStatus,
        monthlyIncome: monthlyIncome,
        isPensioner: isPensioner,
        isDutyBound: isDutyBound);
    await _dbService.addCustomer(newCustomer);
    return Status.ok;
  }

  @override
  void dispose() {
    _valueLists.close();
  }
}
