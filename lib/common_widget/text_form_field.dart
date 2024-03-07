import 'package:flutter/material.dart';


class CommonTextFormFiled extends StatelessWidget{
  TextEditingController controller;
  String label;
  TextInputAction textInputAction;
  String errorMessage;
  TextInputType? textInputType=TextInputType.text;
  CommonTextFormFiled({super.key, required this.controller,required this.label,this.textInputAction= TextInputAction.next,required this.errorMessage,this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.green,
      maxLines:1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      decoration: InputDecoration(labelText: label,labelStyle: const TextStyle(color: Colors.grey)),
      validator: (value){
        return value!.isEmpty ? errorMessage : null;
      },
    );
  }
}