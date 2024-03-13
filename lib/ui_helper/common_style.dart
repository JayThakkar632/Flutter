
import 'package:flutter/material.dart';

TextStyle textStyle(Color color, String fontFamily, double fontSize,FontWeight fontWeight) {
  return TextStyle(
      color: color, fontFamily: fontFamily, fontSize: fontSize,fontWeight: fontWeight);
}

TextStyle styleForButton(Color? textColor) {
  return TextStyle(color: textColor, fontFamily: 'Anta-Regular', fontSize: 16);
}

InputDecoration editText(String hintText,double radius,bool isValidate){
  return InputDecoration(
      hintText: hintText,
      //errorText: isValidate?"Value Can't Be Empty" : null,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius)));
}

ElevatedButton roundedElevatedButton(String? text, Color? bgColor,VoidCallback onPressedCallback, double radius,
    {double heright = 50}) {
  return ElevatedButton(
    onPressed: () {
      onPressedCallback();
    },
    style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
    child: Text(
      "$text",
      style: styleForButton(Colors.white),
    ),
  );
}

OutlinedButton roundedOutLinedButton(String? text, Color? bgColor,VoidCallback onPressedCallback) {
  return OutlinedButton(
    onPressed: () {
      onPressedCallback();
    },
    style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,side: const BorderSide(color: Colors.black,width: 3)),
    child: Text(
      "$text",
      style: styleForButton(Colors.black),
    )
  );
}

OutlinedButton roundedOutLinedButtonOne(String? text, Color? bgColor,VoidCallback onPressedCallback,Color?textColor,) {
  return OutlinedButton(
      onPressed: () {
        onPressedCallback();
      },
      style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,side: const BorderSide(color: Colors.green,width: 1)),
      child: Text(
        "$text",
        style: styleForButton(textColor),
      )
  );
}
