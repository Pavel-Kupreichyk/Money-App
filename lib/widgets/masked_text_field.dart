import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskedTextField extends StatefulWidget {
  final String label;
  final String emptyError;
  final String regExp;
  final String mask;
  final String initial;
  final TextInputType input;
  final bool isReq;
  final IconData icon;
  final Function(String) onSaved;
  MaskedTextField(this.label, this.emptyError, this.regExp, this.mask,
      this.icon, this.initial, this.onSaved,
      {this.input = TextInputType.text, this.isReq = true});
  @override
  _MaskedTextFieldState createState() => _MaskedTextFieldState();
}

class _MaskedTextFieldState extends State<MaskedTextField> {
  MaskTextInputFormatter maskFormatter;
  @override
  void initState() {
    maskFormatter = MaskTextInputFormatter(
        mask: widget.mask, filter: {"#": RegExp(widget.regExp)});
    maskFormatter.formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(
            text: widget.initial,
            selection: TextSelection(
                baseOffset: widget.initial.length,
                extentOffset: widget.initial.length,
                affinity: null,
                isDirectional: false),
            composing: TextRange(start: -1, end: -1)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.input,
      initialValue: widget.initial,
      onSaved: widget.onSaved,
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.mask,
        suffixIcon: Icon(
          widget.icon,
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (!widget.isReq && value.trim().isEmpty) {
          return null;
        } else if (!maskFormatter.isFill()) {
          return widget.emptyError;
        }
        return null;
      },
    );
  }
}
