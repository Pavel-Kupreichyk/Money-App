import 'package:flutter/material.dart';
import 'package:money_app/blocs/edit_customer_page_bloc.dart';
import 'package:money_app/models/value_list.dart';
import 'package:money_app/services/navigation_service.dart';
import 'package:money_app/support/navigation_info.dart';
import 'package:money_app/widgets/date_picker_field.dart';
import 'package:money_app/widgets/masked_text_field.dart';
import 'package:money_app/widgets/selectable_field.dart';
import 'package:money_app/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditCustomerPageBody extends StatelessWidget {
  final EditCustomerBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  EditCustomerPageBody(this._bloc);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<ValueList>>(
          stream: _bloc.valueLists,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var city =
                snapshot.data.firstWhere((data) => data.name == 'City').values;
            var familyStatus = snapshot.data
                .firstWhere((data) => data.name == 'FamilyStatus')
                .values;
            var citizenship = snapshot.data
                .firstWhere((data) => data.name == 'Citizenship')
                .values;
            var disabilityStatus = snapshot.data
                .firstWhere((data) => data.name == 'DisabilityStatus')
                .values;

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTitle('Основная информация'),
                    TextInput(
                        '*Фамилия клиента',
                        'Введите фамилию клиента',
                        'Введите корректную фамилию',
                        r'^[а-яА-Я-]+$',
                        _bloc.lastName,
                        (val) => _bloc.lastName = val),
                    TextInput(
                        '*Имя клиента',
                        'Введите имя клиента',
                        'Введите корректное имя',
                        r'^[а-яА-Я-]+$',
                        _bloc.firstName,
                        (val) => _bloc.firstName = val),
                    TextInput(
                        '*Отчество клиента',
                        'Введите отчество клиента',
                        'Введите корректное отчетсво',
                        r'^[а-яА-Я-]+$',
                        _bloc.middleName,
                        (val) => _bloc.middleName = val),
                    DatePickerField(
                        initDate: _bloc.dateOfBirth,
                        title: '*Дата рождения',
                        onSaved: (val) => _bloc.dateOfBirth = val),
                    _buildTitle('Паспортные данные'),
                    MaskedTextField(
                      '*Серия паспорта',
                      'Введите серию паспорта',
                      r'[A-Z]',
                      '##',
                      Icons.edit,
                      _bloc.passportSeries,
                      (val) => _bloc.passportSeries = val,
                    ),
                    MaskedTextField(
                        '*Номер паспорта',
                        'Введите номер паспорта',
                        r'[0-9]',
                        '#######',
                        Icons.edit,
                        _bloc.passportNum,
                        (val) => _bloc.passportNum = val,
                        input: TextInputType.number),
                    DatePickerField(
                        initDate: _bloc.passportDateOfEmit,
                        title: '*Дата выдачи паспорта',
                        onSaved: (val) => _bloc.passportDateOfEmit = val),
                    TextInput(
                        '*Орган, выдавший паспорт',
                        'Введите орган, выдавший паспорт',
                        'Введите корректное название',
                        r'^[а-яА-Я\s\.0-9-]+$',
                        _bloc.passportEmitter,
                        (val) => _bloc.passportEmitter = val),
                    MaskedTextField(
                      '*Идентификационный номер',
                      'Введите идентификационный номер',
                      r'[A-Z0-9]',
                      '# ###### # ### ## #',
                      Icons.edit,
                      _bloc.id,
                      (val) => _bloc.id = val,
                    ),
                    TextInput(
                        '*Место рождения',
                        'Введите место рождения',
                        'Введите корректное место рождения',
                        r'^[а-яА-Я\s\.0-9-]+$',
                        _bloc.placeOfBirth,
                        (val) => _bloc.placeOfBirth = val),
                    SelectableField(
                        label: '*Город фактического проживания',
                        values: city,
                        initVal: _bloc.city,
                        onChanged: (val) => _bloc.city = val),
                    TextInput(
                        '*Адрес фактического проживания',
                        'Введите адрес проживания',
                        'Введите корректный адрес проживания',
                        r'^[а-яА-Я\s\.0-9-]+$',
                        _bloc.address,
                        (val) => _bloc.address = val),
                    _buildTitle('Дополнительная информация'),
                    MaskedTextField(
                        'Домашний телефон',
                        'Введите домашний телефон',
                        r'[0-9]',
                        '+375 (##) ###-##-##',
                        Icons.phone,
                        _bloc.homePhoneNumber,
                        (val) => _bloc.homePhoneNumber = val,
                        input: TextInputType.number,
                        isReq: false),
                    MaskedTextField(
                        'Мобильный телефон',
                        'Введите мобильный телефон',
                        r'[0-9]',
                        '+375 (##) ###-##-##',
                        Icons.phone_android,
                        _bloc.mobilePhoneNumber,
                        (val) => _bloc.mobilePhoneNumber = val,
                        input: TextInputType.number,
                        isReq: false),
                    TextInput(
                        'E-Mail',
                        'Введите E-Mail',
                        'Введите корректный E-Mail',
                        r'^[^@\s]+@[^@\s\.]+\.[^@\.\s]+$',
                        _bloc.email,
                        (val) => _bloc.email = val,
                        input: TextInputType.emailAddress,
                        isReq: false),
                    TextInput(
                        'Место работы',
                        'Введите место работы',
                        'Введите корректное место работы',
                        r'^[а-яА-Яa-zA-Z\s\.-]+$',
                        _bloc.workPlace,
                        (val) => _bloc.workPlace = val,
                        isReq: false),
                    TextInput(
                        'Должность',
                        'Введите должность',
                        'Введите корректную должность',
                        r'^[а-яА-Яa-zA-Z\s]+$',
                        _bloc.workPosition,
                        (val) => _bloc.workPosition = val,
                        isReq: false),
                    TextInput(
                        'Ежемесячный доход',
                        'Введите ежемесачный доход',
                        'Введите корректное значение',
                        r'^[0-9]+$',
                        _bloc.monthlyIncome,
                        (val) => _bloc.monthlyIncome = val,
                        input: TextInputType.number,
                        isReq: false),
                    SelectableField(
                        label: '*Семейное положение',
                        values: familyStatus,
                        initVal: _bloc.familyStatus,
                        onChanged: (val) => _bloc.familyStatus = val),
                    SelectableField(
                        label: '*Гражданство',
                        values: citizenship,
                        initVal: _bloc.citizenship,
                        onChanged: (val) => _bloc.citizenship = val),
                    SelectableField(
                        label: '*Инвалидность',
                        values: disabilityStatus,
                        initVal: _bloc.disabilityStatus,
                        onChanged: (val) => _bloc.disabilityStatus = val),
                    SelectableField(
                        label: '*Пенсионер',
                        values: ['Нет', 'Да'],
                        initVal: _bloc.isPensioner ? 'Да' : 'Нет',
                        onChanged: (val) => _bloc.isPensioner = val == 'Да'),
                    SelectableField(
                        label: '*Военнообязанный',
                        values: ['Нет', 'Да'],
                        initVal: _bloc.isDutyBound ? 'Да' : 'Нет',
                        onChanged: (val) => _bloc.isDutyBound = val == 'Да'),
                    _submitButton(context),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Text(text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _submitButton(BuildContext context) {
    var navService = Provider.of<NavigationService>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 1,
          child: StreamBuilder<bool>(
              stream: _bloc.isAdding,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return RaisedButton(
                  child: Text(_bloc.btnName),
                  onPressed: snapshot.data
                      ? null
                      : () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            var status = await _bloc.addEditCustomer();
                            if (status == Status.ok) {
                              navService.pushReplacementWithNavInfo(
                                  NavigationInfo.main());
                            } else if (status == Status.idExists) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Идентификационный номер уже существует.')));
                            } else if (status == Status.passportExists) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Паспорт с таким номером уже существует.')));
                            }
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Некоторые поля заполнены некорректно.')));
                          }
                        },
                );
              }),
        ),
      ),
    );
  }
}
