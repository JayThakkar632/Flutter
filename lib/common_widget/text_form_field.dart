import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CommonTextFormFiled extends StatelessWidget{
  String label;
  String name;
  TextInputAction textInputAction;
  String errorMessage;
  TextInputType? textInputType=TextInputType.text;
  CommonTextFormFiled({super.key,required this.label,this.textInputAction= TextInputAction.next,required this.errorMessage,this.textInputType,required this.name});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      cursorColor: Colors.green,
      maxLines:1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      decoration: InputDecoration(labelText: label,labelStyle: const TextStyle(color: Colors.grey)),
      validator: FormBuilderValidators.required(errorText: errorMessage),
    );
  }
}