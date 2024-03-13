import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui_helper/common_style.dart';

class RoundedOutlineButton extends StatelessWidget{
  String title='';
  Color color;
  VoidCallback voidCallback;
  double radius;
  double height;
  double? width;
  RoundedOutlineButton({super.key, required this.title,this.color=Colors.green,required this.voidCallback,this.radius=20,this.height=50,this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
          onPressed: (){
            voidCallback();
          },
          style: OutlinedButton.styleFrom(backgroundColor: color,side: const BorderSide(color: Colors.green,width: 1)),
          child: Text(title,style: styleForButton(Colors.green),)    ),
    );

  }

}