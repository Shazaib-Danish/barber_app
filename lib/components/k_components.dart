

import 'package:flutter/material.dart';

final kTextFormFieldDecoration = InputDecoration(
  hintText: '',
  labelStyle: const TextStyle(
    color: Colors.black,
    fontSize: 17.0,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(
      color: Color(0xffbfb4fd),
      width: 2.0,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(
      color: Color(0xffb8b5cb),
      width: 2.0,
    ),
  ),
);