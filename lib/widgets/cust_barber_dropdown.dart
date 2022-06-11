import 'package:flutter/material.dart';
import 'package:gromify/components/k_components.dart';

class ReusableDropDown extends StatelessWidget {
  ReusableDropDown({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: 'Select',
        style: const TextStyle(
          color: Color(0xff8471FF),
        ),
        items: <String>['Select', 'Customer', 'Barber']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: kTextFormFieldDecoration.copyWith(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffb8b5cb),)
          ),

        ),
        onChanged: onChanged);
  }
}
