import 'package:money_app/models/customer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/support/disposable.dart';

class EditCustomerBloc implements Disposable {
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String dateOfBirth = DateTime.now().toString();
  String passportSeries = '';
  String passportNum = '';
  String passportEmitter = '';
  String passportDateOfEmit = DateTime.now().toString();
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

  EditCustomerBloc(this._dbService, [this._currCustomer]){
    if(_currCustomer != null) {
      firstName = _currCustomer.firstName;
      middleName = _currCustomer.middleName;
      lastName = _currCustomer.lastName;
      dateOfBirth = _currCustomer.dateOfBirth;
      passportSeries = _currCustomer.passportSeries;
      passportNum = _currCustomer.passportNum;
      passportEmitter = _currCustomer.passportEmitter;
      passportDateOfEmit = _currCustomer.passportDateOfEmit;
      id = _currCustomer.id;
      placeOfBirth = _currCustomer.placeOfBirth;
      city = _currCustomer.city;
      address = _currCustomer.address;
      mobilePhoneNumber = _currCustomer.mobilePhoneNumber;
      homePhoneNumber = _currCustomer.homePhoneNumber;
      email = _currCustomer.email;
      workPlace = _currCustomer.workPlace;
      workPosition = _currCustomer.workPosition;
      familyStatus = _currCustomer.familyStatus;
      citizenship = _currCustomer.citizenship;
      disabilityStatus = _currCustomer.disabilityStatus;
      monthlyIncome = _currCustomer.monthlyIncome;
      isPensioner = _currCustomer.isPensioner;
      isDutyBound = _currCustomer.isDutyBound;
    }
  }

  @override
  void dispose() {}
}
