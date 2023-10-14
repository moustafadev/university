import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  final Function onChanged;
  final String text;

  const CheckboxWidget({super.key, required this.onChanged, required this.text});
  @override
  _CheckboxWidget createState() => _CheckboxWidget();
}

class _CheckboxWidget extends State<CheckboxWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Checkbox(
          value: _isChecked,
          visualDensity: VisualDensity.compact,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
            widget.onChanged();
          },
        ),
      ],
    );
  }
}
