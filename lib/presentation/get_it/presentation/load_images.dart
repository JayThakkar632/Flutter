import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/get_it/repository/locator.dart';
import 'package:first_flutter_demo_app/presentation/get_it/repository/meme_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/meme.dart';

class LoadImagesScreen extends StatefulWidget {
  const LoadImagesScreen({super.key});

  @override
  State<LoadImagesScreen> createState() => _LoadImagesScreenState();
}

class _LoadImagesScreenState extends State<LoadImagesScreen> {
   Meme meme=Meme();
  @override
  Widget build(BuildContext context) {
    return TopWidget(
        title: 'Get It',
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.skip_next),
          onPressed: () async {
            var data=await locator.get<MemeRepo>().getMeme();
            setState((){
              meme=data;
            });
          },
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: meme!=null ? Center(child: Text(meme.caption??"")): SizedBox(),
        ));
  }
}
