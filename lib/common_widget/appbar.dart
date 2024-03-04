import 'package:flutter/material.dart';

AppBar appBar({required String title,required BuildContext context,bool isShowBack=true}){
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.green,
    leading: isShowBack ? InkWell(
      child: const Icon(Icons.arrow_back,
        color: Colors.white,),
      onTap:(){Navigator.pop(context);}
      ,
    ):null,
    title: Text(title,style:const TextStyle(color: Colors.white, fontFamily: 'Anta-Regular', fontSize: 22)),
  );
}