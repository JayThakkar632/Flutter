import 'package:first_flutter_demo_app/common_widget/round_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height*0.2,
        width: MediaQuery.sizeOf(context).width*0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            const SizedBox(height: 15,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedElevatedButton(title: widget.negativeButtonText, voidCallback: ()=>widget.negativeButtonCallBack(),color: Colors.red,radius: 30,width: 100,),
                  RoundedElevatedButton(title: widget.positiveButtonText, voidCallback: ()=>widget.positiveButtonCallBack(),radius: 30,width: 100,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
