import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int selectedIndex = 0;
  static const List arrLanguages = [
    Text('Flutter'),
    Text('Android'),
    Text('IOS'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drawer Demo")),
      body: Center(
        child: arrLanguages[selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Flutter'),
              selected: selectedIndex == 0,
              onTap: () {
                onClick(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Android'),
              selected: selectedIndex == 1,
              onTap: () {
                onClick(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('IOS'),
              selected: selectedIndex == 2,
              onTap: () {
                onClick(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  void onClick(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}


