import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String value;
  final String placeholder;
  final String validation;
  final List<String> dropdownValues;
  final Function callback;
  CustomDropdownWidget(
      {this.value,
      this.placeholder,
      this.validation,
      this.dropdownValues,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: this.value,
      validator: (value) {
        if (value == null) {
          return this.validation;
        }
        return null;
      },
      onChanged: (String newValue) {
        this.callback(newValue);
      },
      hint: Text(this.placeholder),
      items: dropdownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
