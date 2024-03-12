import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget{

  String positiveButtonText;
  String negativeButtonText;
  String title;
  VoidCallback positiveButtonCallBack;
  VoidCallback negativeButtonCallBack;

  CustomDialog({super.key,required this.title,required this.positiveButtonText,required this.negativeButtonText,required this.positiveButtonCallBack,required this.negativeButtonCallBack});

  @override
  State<CustomDialog> createState() => _DialogState();
}

class _DialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: [
        TextButton(
        onPressed: () => widget.negativeButtonCallBack(),
        child: Text(widget.negativeButtonText),
        ),
        TextButton(
          onPressed: ()=> widget.positiveButtonCallBack(),
          child: Text(widget.positiveButtonText),
        ),
      ],
    );
  }
}
