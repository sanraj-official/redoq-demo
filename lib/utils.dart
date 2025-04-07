import 'package:flutter/material.dart';

InputBorder formBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.red),
  );
}

Widget provideVSpace({double height = 8.0}) {
  return SizedBox(height: height);
}

TextStyle headingStyle({double fontSize = 18, FontWeight fontWeight = FontWeight.w400,Color color = Colors.black}) {
  return  TextStyle(fontSize: fontSize, fontWeight: fontWeight,color: color);
}