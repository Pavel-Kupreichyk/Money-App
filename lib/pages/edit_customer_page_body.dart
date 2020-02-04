import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:money_app/blocs/edit_customer_page_bloc.dart';
import 'package:money_app/widgets/date_picker_field.dart';

class EditCustomerPageBody extends StatelessWidget {
  final EditCustomerBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  EditCustomerPageBody(this._bloc);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitle('Основная информация'),
              _buildTextInput(
                  '*Фамилия клиента',
                  'Введите фамилию клиента',
                  'Введите корректную фамилию',
                  r'^[а-яА-Я]+$',
                  _bloc.lastName,
                  (val) => _bloc.lastName = val),
              _buildTextInput(
                  '*Имя клиента',
                  'Введите имя клиента',
                  'Введите корректное имя',
                  r'^[а-яА-Я]+$',
                  _bloc.firstName,
                  (val) => _bloc.firstName = val),
              _buildTextInput(
                  '*Отчество клиента',
                  'Введите отчество клиента',
                  'Введите корректное отчетсво',
                  r'^[а-яА-Я]+$',
                  _bloc.middleName,
                  (val) => _bloc.middleName = val),
              DatePickerField(
                  initDate: DateTime.parse(_bloc.dateOfBirth),
                  title: '*Дата рождения',
                  validator: (s) => s.toString(),
                  onSaved: (val) => _bloc.dateOfBirth = val.toString()),
              _buildTitle('Паспортные данные'),
              _maskedTextInput(
                '*Серия паспорта',
                'Введите серию паспорта',
                r'[A-Z]',
                '##',
                Icons.edit,
                _bloc.passportSeries,
                (val) => _bloc.passportSeries = val,
              ),
              _maskedTextInput(
                  '*Номер паспорта',
                  'Введите номер паспорта',
                  r'[A-Z0-9]',
                  '#######',
                  Icons.edit,
                  _bloc.passportNum,
                  (val) => _bloc.passportNum = val,
                  input: TextInputType.number),
              DatePickerField(
                  initDate: DateTime.parse(_bloc.passportDateOfEmit),
                  title: '*Дата выдачи паспорта',
                  validator: (s) => s.toString(),
                  onSaved: (val) => _bloc.passportDateOfEmit = val.toString()),
              _maskedTextInput(
                '*Идентификационный номер',
                'Введите идентификационный номер',
                r'[A-Z0-9]',
                '# ###### # ### ## #',
                Icons.edit,
                _bloc.id,
                (val) => _bloc.id = val,
              ),
              _buildTextInput(
                  '*Место рождения',
                  'Введите место рождения',
                  'Введите корректное место рождения',
                  r'^[а-яА-Я\s]+$',
                  _bloc.placeOfBirth,
                  (val) => _bloc.placeOfBirth = val),
              _selectableField(
                  '*Город фактического проживания',
                  ['Минск', 'Гродно', 'Гомель', 'Витебск', 'Могилев', 'Брест'],
                  _bloc.city,
                  (val) => _bloc.city = val),
              _buildTextInput(
                  '*Адрес фактического проживания',
                  'Введите адрес проживания',
                  'Введите корректный адрес проживания',
                  r'^[а-яА-Я\s]+$',
                  _bloc.address,
                  (val) => _bloc.address = val),
              _buildTitle('Дополнительная информация'),
              _maskedTextInput(
                  'Домашний телефон',
                  'Введите домашний телефон',
                  r'[0-9]',
                  '+375 (##) ###-##-##',
                  Icons.phone,
                  _bloc.homePhoneNumber,
                  (val) => _bloc.homePhoneNumber = val,
                  input: TextInputType.number,
                  isReq: false),
              _maskedTextInput(
                  'Мобильный телефон',
                  'Введите мобильный телефон',
                  r'[0-9]',
                  '+375 (##) ###-##-##',
                  Icons.phone_android,
                  _bloc.mobilePhoneNumber,
                  (val) => _bloc.mobilePhoneNumber = val,
                  input: TextInputType.number,
                  isReq: false),
              _buildTextInput(
                  'E-Mail',
                  'Введите E-Mail',
                  'Введите корректный E-Mail',
                  r'^[^@\s]+@[^@\s\.]+\.[^@\.\s]+$',
                  _bloc.email,
                  (val) => _bloc.email = val,
                  input: TextInputType.emailAddress,
                  isReq: false),
              _buildTextInput(
                  'Место работы',
                  'Введите место работы',
                  'Введите корректное место работы',
                  r'^[а-яА-Яa-zA-Z\s]+$',
                  _bloc.workPlace,
                  (val) => _bloc.workPlace = val,
                  isReq: false),
              _buildTextInput(
                  'Должность',
                  'Введите должность',
                  'Введите корректную должность',
                  r'^[а-яА-Яa-zA-Z\s]+$',
                  _bloc.workPosition,
                  (val) => _bloc.workPosition = val,
                  isReq: false),
              _buildTextInput(
                  'Ежемесячный доход',
                  'Введите ежемесачный доход',
                  'Введите корректное значение',
                  r'^[0-9]+$',
                  _bloc.monthlyIncome,
                  (val) => _bloc.monthlyIncome = val,
                  input: TextInputType.number,
                  isReq: false),
              _selectableField(
                  '*Семейное положение',
                  ['Свободен/Свободна', 'Женат/Замужем'],
                  _bloc.familyStatus,
                  (val) => _bloc.familyStatus = val),
              _selectableField(
                  '*Гражданство',
                  ['Беларусь', 'Россия', 'Украина'],
                  _bloc.citizenship,
                  (val) => _bloc.citizenship = val),
              _selectableField(
                  '*Инвалидность',
                  ['Нет', '1 группа', '2 группа', '3 группа'],
                  _bloc.disabilityStatus,
                  (val) => _bloc.disabilityStatus = val),
              _selectableField(
                  '*Пенсионер',
                  ['Нет', 'Да'],
                  _bloc.isPensioner ? 'Да' : 'Нет',
                  (val) => _bloc.isPensioner = val == 'Да'),
              _selectableField(
                  '*Военнообязанный',
                  ['Нет', 'Да'],
                  _bloc.isDutyBound ? 'Да' : 'Нет',
                  (val) => _bloc.isDutyBound = val == 'Да'),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Text(text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextInput(String label, String emptyError, String incorrectError,
      String regExp, String initial, Function(String) onSaved,
      {TextInputType input = TextInputType.text, bool isReq = true}) {
    return TextFormField(
      keyboardType: input,
      initialValue: initial,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(
          Icons.edit,
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (value.trim().isEmpty) {
          return isReq ? emptyError : null;
        } else if (!value.contains(RegExp(regExp))) {
          return incorrectError;
        }
        return null;
      },
    );
  }

  Widget _selectableField(String label, List<String> values, String value,
      Function(String) onChanged) {
    return StatefulBuilder(
      builder: (_, setState) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
          ),
          items: values
              .map((val) =>
                  DropdownMenuItem<String>(value: val, child: Text(val)))
              .toList(),
          onChanged: (val) {
            onChanged(val);
            setState(() => value = val);
          },
          value: value,
        );
      },
    );
  }

  Widget _maskedTextInput(String label, String emptyError, String regExp,
      String mask, IconData icon, String initial, Function(String) onSaved,
      {TextInputType input = TextInputType.text, bool isReq = true}) {
    var maskFormatter =
        MaskTextInputFormatter(mask: mask, filter: {"#": RegExp(regExp)});
    return TextFormField(
      keyboardType: input,
      initialValue: initial,
      onSaved: onSaved,
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        labelText: label,
        hintText: mask,
        suffixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (!isReq && value.trim().isEmpty) {
          return null;
        } else if (!maskFormatter.isFill()) {
          return emptyError;
        }
        return null;
      },
    );
  }

  Widget _submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 1,
          child: RaisedButton(
            child: Text('Добавить'),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_formKey.currentState.validate()) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
            },
          ),
        ),
      ),
    );
  }
}
