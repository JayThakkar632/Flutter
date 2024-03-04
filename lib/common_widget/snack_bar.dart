import 'package:flutter/material.dart';

void showSnackBar(String msg,BuildContext context){
  var snackBar= SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'OK',
        onPressed: (){
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      )

  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}