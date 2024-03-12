import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key, required this.child, required this.title, this.isMainPage = false,this.bottomNavigationBar});

  final Widget child;
  final String title;
  final bool isMainPage;
  final BottomNavigationBar? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        leading: isMainPage ? InkWell(
          child: const Icon(Icons.arrow_back,
            color: Colors.white,),
          onTap:(){Navigator.pop(context);}
          ,
        ):null,
        title: Text(title,style:const TextStyle(color: Colors.white, fontFamily: 'Anta-Regular', fontSize: 22)),
      ),
      bottomNavigationBar: bottomNavigationBar,
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
