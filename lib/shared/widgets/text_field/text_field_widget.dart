import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final String? Function(String?) validator;
  final String? Function(String?) onSaved;
  final String initialValue;

  const TextFieldWidget(
      {Key? key,
      required this.labelText,
      required this.icon,
      required this.validator,
      required this.onSaved,
      this.initialValue = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(bottom: 15),
      child: TextFormField(
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
