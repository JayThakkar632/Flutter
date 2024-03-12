import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common_widget/top_widget.dart';
import '../beer_module/beer_list_screen.dart';
import '../beer_module_bloc/data/repository/beer_repository.dart';
import '../beer_module_bloc/presentation/bloc_beer_list_screen.dart';
import '../beer_module_cubit/logic/post_cubit.dart';
import '../beer_module_cubit/presentation/beer_module/cubit_beer_list_screen.dart';
import '../user_module/user_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';


class ProgramListScreen extends StatelessWidget {
  const ProgramListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Listing();
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

class _ListingState extends State<Listing> with AutomaticKeepAliveClientMixin {

  final List<ColorName> arrayList = [
    ColorName(color: Colors.red, name: 'Beer'),
    ColorName(color: Colors.green, name: 'User Listing'),
    ColorName(color: Colors.yellow, name: 'Beer Listing Using Cubit'),
    ColorName(color: const Color(0xffb74093), name: 'Beer Listing Using Bloc'),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
          MaterialPageRoute(builder: (context) => const BeerListScreen()),
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
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CubitBeerListScreen(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BlocBeerListScreen(),
          ),
        );
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
