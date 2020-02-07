import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final Function(DateTime) validator;
  final Function(DateTime) onSaved;
  final DateTime initDate;
  final String title;

  DatePickerField({this.title, DateTime initDate, this.validator, this.onSaved})
      : this.initDate = initDate ?? DateTime.now();

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  TextEditingController _controller;
  DateTime _currDateTime;
  String get _formattedDate =>
      '${_currDateTime.day}/${_currDateTime.month}/${_currDateTime.year}';

  @override
  void initState() {
    _currDateTime = widget.initDate;
    _controller = TextEditingController(text: _formattedDate);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.date_range,
          color: Colors.grey,
        ),
        labelText: widget.title ?? '',
      ),
      onTap: pickDate,
      controller: _controller,
      validator: (_) => widget.validator != null ? widget.validator(_currDateTime) : null,
      onSaved: (_) => widget.onSaved != null ? widget.onSaved(_currDateTime) : null,
      readOnly: true,
    );
  }

  pickDate() async {
    var dt = await showDatePicker(
        context: context,
        initialDate: _currDateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (dt != null) {
      _currDateTime = dt;
      _controller.text = _formattedDate;
    }
  }
}
