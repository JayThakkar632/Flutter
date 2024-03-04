import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common_widget/appbar.dart';
import '../beer_screen.dart';
import '../user_list_screen.dart';

class ProgramListScreen extends StatelessWidget {
  const ProgramListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Listing());
  }
}

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class ColorName {
  final Color color;
  final String name;

  ColorName({required this.color, required this.name});
}

class _ListingState extends State<Listing> {
  final List<ColorName> arrayList = [
    ColorName(color: Colors.red, name: 'Beer'),
    ColorName(color: Colors.green, name: 'User Listing'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(title: "Programme Listing", context: context),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                navigateToScreen(context, index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: arrayList[index].color,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  height: 100,
                  child: Center(
                      child: Text(
                        arrayList[index].name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                ),
              ),
            );
          },
          itemCount: arrayList.length,
        ),
      ),
    );
  }

  void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BeerViewScreen(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserListScreen(),
          ),
        );
        break;
    }
  }
}
