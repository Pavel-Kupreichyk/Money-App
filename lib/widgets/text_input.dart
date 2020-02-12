import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String emptyError;
  final String initial;
  final String regExp;
  final String incorrectError;
  final Function(String) onSaved;
  final TextInputType input;
  final bool isReq;
  final bool isIconEnabled;

  TextInput(this.label, this.emptyError, this.incorrectError, this.regExp,
      this.initial, this.onSaved,
      {this.input = TextInputType.text,
      this.isReq = true,
      this.isIconEnabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: input,
      initialValue: initial,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: isIconEnabled
            ? const Icon(
                Icons.edit,
                color: Colors.grey,
              )
            : null,
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
}
