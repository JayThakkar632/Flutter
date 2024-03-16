import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class EquatableDemo extends StatefulWidget {
  const EquatableDemo({super.key});

  @override
  State<EquatableDemo> createState() => _EquatableDemoState();
}

class UserModel extends Equatable{
  int id;
  String name;

  UserModel({required this.id,required this.name});

  @override

  List<Object?> get props => [id,name];
}

class _EquatableDemoState extends State<EquatableDemo> {

  var user1=UserModel(id: 1, name: "Jay");
  var user2=UserModel(id: 1, name: "Jay");


  @override
  Widget build(BuildContext context) {
    return  TopWidget(title: 'Equatable', child: Center(child: Text('${user1 == user2}')));
  }
}
