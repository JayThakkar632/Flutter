import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadImagesScreen extends StatelessWidget {
  const LoadImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TopWidget(
        title: 'Get It',
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.skip_next),
          onPressed: () {

          },
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        ));
  }
}
