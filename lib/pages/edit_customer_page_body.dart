import 'package:flutter/material.dart';
import 'package:money_app/blocs/edit_customer_page_bloc.dart';
import 'package:money_app/widgets/date_picker_field.dart';

class EditCustomerPageBody extends StatelessWidget {
  final EditCustomerBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  EditCustomerPageBody(this._bloc);
  DateTime get _dateOfBirth => _bloc.hasCustomer
      ? DateTime.parse(_bloc.currCustomer.dateOfBirth)
      : DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          children: <Widget>[
            _buildTextInput('Фамилия клиента', 'Введите фамилию клиента',
                'Введите корректную фамилию', r'^[а-яА-Я]+$'),
            _buildTextInput('Имя клиента', 'Введите имя клиента',
                'Введите корректное имя', r'^[а-яА-Я]+$'),
            _buildTextInput('Отчество клиента', 'Введите отчество клиента',
                'Введите корректное отчетсво', r'^[а-яА-Я]+$'),
            DatePickerField(
              initDate: _dateOfBirth,
              title: 'Дата рождения',
              validator: (s) => s.toString(),
            ),
            _buildTextInput('Серия паспорта', 'Введите серию паспорта',
                'Введите корректную серию паспорта', r'^[a-zA-Z0-9]+$'),
            //№ паспорта
            DatePickerField(
              initDate: _dateOfBirth,
              title: 'Дата выдачи паспорта',
              validator: (s) => s.toString(),
            ),
            //Идент. номер
            _buildTextInput('Место рождения', 'Введите место рождения',
                'Введите корректное место рождения', r'^[а-яА-Я]+$'),
            //Город факт. прож.
            _buildTextInput('Адрес фактического проживания', 'Введите адрес проживания',
                'Введите корректный адрес проживания', r'^[а-яА-Я]+$'),
            _buildTextInput('E-Mail', 'Введите E-Mail',
                'Введите корректный E-Mail', r'^[^@\s]+@[^@\s\.]+\.[^@\.\s]+$'),
            _buildTextInput('Место работы', 'Введите место работы',
                'Введите корректное место работы', r'^[а-яА-Я]+$'),
            _buildTextInput('Место должность', 'Введите должность',
                'Введите корректную должность', r'^[а-яА-Я]+$'),
            //семейное положение
            //гражданство
            //инвалидность
            //пенсионет
            //доход
            //военнообязанный
            _submitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput(
      String label, String emptyError, String incorrectError, String regExp) {
    return TextFormField(
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
