import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:flutter/material.dart';

import '../model/user_freezed_model.dart';

class FreezedDemo extends StatefulWidget {
  const FreezedDemo({super.key});

  @override
  State<FreezedDemo> createState() => _FreezedDemoState();
}

class _FreezedDemoState extends State<FreezedDemo> {
  @override
  Widget build(BuildContext context) {
    final userModel = UserFreezedModel("1", "Jay");
    final userModel2 = userModel.copyWith(name: "Raj");
    final userModel3 = UserFreezedModel("1", "Jay");

    final serialized = userModel.toJson();
    final deSerialized = UserFreezedModel.fromJson(serialized);

    print(userModel);
    print(userModel2);
    print(userModel == userModel3);
    print(serialized);
    print(deSerialized);

    //Union
    print(const Union(42));
    print(const Union.loading());
    print(const Union.error("Error"));

    return TopWidget(title: 'Freezed', child: Container());
  }
}
