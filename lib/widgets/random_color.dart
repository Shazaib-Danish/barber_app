import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/light_color.dart';


Color randomColor(BuildContext context) {
  var random = Random();
  final colorList = [
    Theme.of(context).primaryColor,
    LightColor.orange,
    LightColor.green,
    LightColor.grey,
    LightColor.lightOrange,
    LightColor.skyBlue,
    LightColor.titleTextColor,
    Colors.red,
    Colors.brown,
    LightColor.purpleExtraLight,
    LightColor.skyBlue,
  ];
  var color = colorList[random.nextInt(colorList.length)];
  return color;
}