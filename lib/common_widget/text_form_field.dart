import 'package:flutter/material.dart';


class CommonTextFormFiled extends StatelessWidget{
  TextEditingController controller;
  String label;
  TextInputAction? textInputAction=TextInputAction.next;
  String errorMessage;
  TextInputType? textInputType=TextInputType.text;
  CommonTextFormFiled({required this.controller,required this.label,this.textInputAction,required this.errorMessage,this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.green,
      maxLines:1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      inputFormatters: [

      ],
      decoration: InputDecoration(labelText: label,labelStyle: TextStyle(color: Colors.grey)),
      validator: (value){
        return value!.isEmpty ? errorMessage : null;
      },
    );
  }

}


/*TextFormField textFormField({required TextEditingController stateController,required TextInputAction textInputAction,required String label,String? errorMessage,String? regexMsg, int length=10}){
  return TextFormField(
    controller: stateController,
    cursorColor: Colors.green,
    maxLines:1,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textInputAction: textInputAction,
    decoration: InputDecoration(labelText: label,labelStyle: TextStyle(color: Colors.grey)),
    validator: (value){
      if(value!.isEmpty){
        return errorMessage;
      }else if(regexMsg.is)
      return value!.isEmpty ?'Please enter state':null;
    },
  );
}*/