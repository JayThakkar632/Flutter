import 'dart:math';

import 'package:first_flutter_demo_app/presentation/get_it/presentation/load_images.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/presentation/bloc_user_list_screen.dart';
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
  final Widget screeName;

  ColorName({required this.color, required this.name,required this.screeName});
}

class _ListingState extends State<Listing>{

  final List<ColorName> arrayList = [
    ColorName(color: Colors.red, name: 'Beer',screeName: const BeerListScreen()),
    ColorName(color: Colors.green, name: 'User Listing',screeName: const UserListScreen()),
    ColorName(color: Colors.yellow, name: 'Beer Listing Using Cubit',screeName: const CubitBeerListScreen()),
    ColorName(color: const Color(0xffb74093), name: 'Beer Listing Using Bloc',screeName: const BlocBeerListScreen()),
    ColorName(color: Colors.cyanAccent, name: 'User Listing Using Bloc',screeName: const UserListScreenWithBloc()),
    ColorName(color: Colors.purpleAccent, name: 'Get It',screeName: const LoadImagesScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) => arrayList[index].screeName),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: arrayList[index].color,
                      borderRadius: const BorderRadius.all(Radius.circular(50))),
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
}
