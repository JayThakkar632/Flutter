import 'dart:ui';

import 'package:flutter/material.dart';

import '../ui_helper/common_style.dart';


class RoundedElevatedButton extends StatelessWidget{
  String title='';
  Color color;
  VoidCallback voidCallback;
  double radius;
  RoundedElevatedButton({required this.title,this.color=Colors.green,required this.voidCallback,this.radius=20,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
         onPressed: (){
           voidCallback();
         },
      child: Text(title,style: styleForButton(Colors.white),),
    style: ElevatedButton.styleFrom(backgroundColor: color,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!))),
    );

  }

}


/*ElevatedButton roundedElevatedButton(String title, Color bgColor,VoidCallback onPressedCallback, double radius) {
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
}*/




