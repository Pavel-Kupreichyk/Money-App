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
            children: <Widget>[
              _buildTextInput(
                  'Фамилия клиента',
                  'Введите фамилию клиента',
                  'Введите корректную фамилию',
                  r'^[а-яА-Я]+$',
                  _bloc.lastName,
                  (val) => _bloc.lastName = val),
              _buildTextInput(
                  'Имя клиента',
                  'Введите имя клиента',
                  'Введите корректное имя',
                  r'^[а-яА-Я]+$',
                  _bloc.firstName,
                  (val) => _bloc.firstName = val),
              _buildTextInput(
                  'Отчество клиента',
                  'Введите отчество клиента',
                  'Введите корректное отчетсво',
                  r'^[а-яА-Я]+$',
                  _bloc.middleName,
                  (val) => _bloc.middleName = val),
              DatePickerField(
                  initDate: DateTime.parse(_bloc.dateOfBirth),
                  title: 'Дата рождения',
                  validator: (s) => s.toString(),
                  onSaved: (val) => _bloc.dateOfBirth = val.toString()),
              _maskedTextInput('Серия паспорта', 'Введите серию паспорта',
                  r'[A-Z]', '##', Icons.edit, _bloc.passportSeries),
              _maskedTextInput(
                  'Номер паспорта',
                  'Введите номер паспорта',
                  r'[A-Z0-9]',
                  '#######',
                  Icons.edit,
                  _bloc.passportNum,
                  TextInputType.number),
              DatePickerField(
                  initDate: DateTime.parse(_bloc.passportDateOfEmit),
                  title: 'Дата выдачи паспорта',
                  validator: (s) => s.toString(),
                  onSaved: (val) => _bloc.passportDateOfEmit = val.toString()),
              _maskedTextInput(
                  'Идентификационный номер',
                  'Введите идентификационный номер',
                  r'[A-Z0-9]',
                  '# ###### # ### ## #',
                  Icons.edit,
                  _bloc.id),
              _buildTextInput(
                  'Место рождения',
                  'Введите место рождения',
                  'Введите корректное место рождения',
                  r'^[а-яА-Я]+$',
                  _bloc.placeOfBirth,
                  (val) => _bloc.placeOfBirth = val),
              _selectableField(
                  'Город фактического проживания',
                  ['Минск', 'Гродно', 'Гомель', 'Витебск', 'Могилев', 'Брест'],
                  _bloc.city,
                  (val) => _bloc.city = val),
              _buildTextInput(
                  'Адрес фактического проживания',
                  'Введите адрес проживания',
                  'Введите корректный адрес проживания',
                  r'^[а-яА-Я]+$',
                  _bloc.address,
                  (val) => _bloc.address = val),
              _maskedTextInput(
                  'Домашний телефон',
                  'Введите домашний телефон',
                  r'[0-9]',
                  '+375 (##) ###-##-##',
                  Icons.phone,
                  _bloc.homePhoneNumber,
                  TextInputType.number),
              _maskedTextInput(
                  'Мобильный телефон',
                  'Введите мобильный телефон',
                  r'[0-9]',
                  '+375 (##) ###-##-##',
                  Icons.phone_android,
                  _bloc.mobilePhoneNumber,
                  TextInputType.number),
              _buildTextInput(
                  'E-Mail',
                  'Введите E-Mail',
                  'Введите корректный E-Mail',
                  r'^[^@\s]+@[^@\s\.]+\.[^@\.\s]+$',
                  _bloc.email,
                  (val) => _bloc.email = val,
                  TextInputType.emailAddress),
              _buildTextInput(
                  'Место работы',
                  'Введите место работы',
                  'Введите корректное место работы',
                  r'^[а-яА-Я]+$',
                  _bloc.workPlace,
                  (val) => _bloc.workPlace = val),
              _buildTextInput(
                  'Место должность',
                  'Введите должность',
                  'Введите корректную должность',
                  r'^[а-яА-Я]+$',
                  _bloc.workPosition,
                  (val) => _bloc.workPosition = val),
              _selectableField(
                  'Семейное положение',
                  ['Свободен/Свободна', 'Женат/Замужем'],
                  _bloc.familyStatus,
                  (val) => _bloc.familyStatus = val),
              _selectableField('Гражданство', ['Беларусь', 'Россия', 'Украина'],
                  _bloc.citizenship, (val) => _bloc.citizenship = val),
              _selectableField(
                  'Инвалидность',
                  ['Нет', '1 группа', '2 группа', '3 группа'],
                  _bloc.disabilityStatus,
                  (val) => _bloc.disabilityStatus = val),
              //пенсионет
              _buildTextInput(
                  'Ежемесячный доход',
                  'Введите ежемесачный доход',
                  'Введите корректное значение',
                  r'^[0-9]+$',
                  _bloc.monthlyIncome,
                  (val) => _bloc.monthlyIncome = val,
                  TextInputType.number),
              //военнообязанный
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(String label, String emptyError, String incorrectError,
      String regExp, String saveField, Function(String) onSaved,
      [TextInputType input = TextInputType.text]) {
    return TextFormField(
      keyboardType: input,
      //initialValue: saveField,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(
          Icons.edit,
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return emptyError;
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
      String mask, IconData icon, String saveField,
      [TextInputType input = TextInputType.text]) {
    var maskFormatter =
        MaskTextInputFormatter(mask: mask, filter: {"#": RegExp(regExp)});
    return TextFormField(
      keyboardType: input,
      initialValue: saveField,
      onSaved: (val) => saveField = val,
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
        if (!maskFormatter.isFill()) {
          return emptyError;
        }
        return null;
      },
    );
  }

  Widget _submitButton(BuildContext context) {
    return RaisedButton(
      child: Text('Добавить'),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_formKey.currentState.validate()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data')));
        }
      },
    );
  }
}
