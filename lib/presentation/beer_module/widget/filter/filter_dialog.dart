import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common_widget/round_elevated_button.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:intl/intl.dart';


class FilterDialog extends StatefulWidget{
  final Function(String foodSearch,String brewedBefore,String brewedAfter) onOkayCallback;
  VoidCallback onResetCallBack;
  String foodSearch;
  String brewedBefore;
  String brewedAfter;
  FilterDialog({super.key, required this.onOkayCallback,required this.onResetCallBack,required this.foodSearch,required this.brewedBefore,required this.brewedAfter});
  @override
  State<FilterDialog> createState() => _FilterDialogState();
}


class _FilterDialogState extends State<FilterDialog> {

  final _brewedBeforeController=TextEditingController();
  final _brewedAfterController=TextEditingController();
  final _foodController=TextEditingController();



  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                readOnly: true,
                onTap: (){
                  openCalender(context,"");
                },
                controller: _brewedAfterController,
                decoration: InputDecoration(
                  labelText: 'Brewed After',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              height: 50,
              child: TextField(
                readOnly: true,
                onTap: (){
                  openCalender(context,"Brewed Before");
                },
                controller: _brewedBeforeController,
                decoration: InputDecoration(
                  labelText: 'Brewed Before',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _foodController,
                decoration: InputDecoration(
                  labelText: 'Search here for food',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedElevatedButton(title: 'Reset',voidCallback: (){
                  _foodController.text='';
                  _brewedBeforeController.text='';
                  _brewedAfterController.text='';
                  return widget.onResetCallBack();
                },color: Colors.blue,),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    onPressed:()=>widget.onOkayCallback(_foodController.text,_brewedBeforeController.text,_brewedAfterController.text)
                    ,child: const Text('Okay',style: TextStyle(color: Colors.white))),
              ],
            )
          ],
        ),
      ),
    );
  }
  void setData() {
    _foodController.text=widget.foodSearch;
    _brewedBeforeController.text=widget.brewedBefore;
    _brewedAfterController.text=widget.brewedAfter;
  }

  Future<void> openCalender(BuildContext context,String type) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );

      var formattedDate= selected != null ?  DateFormat('MM/yyyy').format(selected) : '';
      setState(() {
        type.isNotEmpty ? _brewedBeforeController.text = formattedDate : _brewedAfterController.text = formattedDate;
      });
  }
}



