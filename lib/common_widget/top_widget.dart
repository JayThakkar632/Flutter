import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key, required this.child, required this.title, this.isMainPage = false,this.bottomNavigationBar,this.floatingActionButton,this.bgColor=Colors.white});

  final Widget child;
  final String title;
  final bool isMainPage;
  final BottomNavigationBar? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        leading: !isMainPage ? InkWell(
          child: const Icon(Icons.arrow_back,
            color: Colors.white,),
          onTap:(){Navigator.pop(context);}
          ,
        ):null,
        title: Text(title,style:const TextStyle(color: Colors.white, fontFamily: 'Anta-Regular', fontSize: 22)),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: child);
      // body: Column(
      //   children: [
      //     Container(
      //       width: MediaQuery.sizeOf(context).width,
      //       height: 10,
      //       color: Colors.red,
      //     ),
      //     Expanded(child: child),
      //   ],
      // ),);
  }
}
