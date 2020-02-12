import 'package:flutter/material.dart';

class SelectableField extends StatefulWidget {
  final String label;
  final List<String> values;
  final Function(String) onChanged;
  final String initVal;

  SelectableField({this.label, this.values, this.onChanged, this.initVal});

  @override
  _SelectableFieldState createState() => _SelectableFieldState();
}

class _SelectableFieldState extends State<SelectableField> {
  String value;
  @override
  void initState() {
    value = widget.initVal;
    super.initState();
  }

  @override
  void didUpdateWidget(SelectableField oldWidget) {
    setState(() => value = widget.initVal);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      items: widget.values
          .map((val) => DropdownMenuItem<String>(value: val, child: Text(val)))
          .toList(),
      onChanged: (val) {
        widget.onChanged(val);
        setState(() => value = val);
      },
      value: value,
    );
  }
}
