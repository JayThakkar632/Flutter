import 'package:flutter/material.dart';

import '../ui_helper/common_style.dart';

ElevatedButton roundedElevatedButton(String title, Color bgColor,VoidCallback onPressedCallback, double radius) {
  return ElevatedButton(
    onPressed: () {
      onPressedCallback();
    },
    style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
    child: Text(
      title,
      style: styleForButton(Colors.white),
    ),
  );
}
