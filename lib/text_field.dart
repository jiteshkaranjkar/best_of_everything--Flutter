import 'package:flutter/material.dart';

class TestFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
      decoration: new InputDecoration(labelText: "Email "),
      validator: (value) =>
          value.isEmpty ? "Email value cannot be empty" : null,
      //onSaved: (value) => _email = value,
    ));
  }
}
