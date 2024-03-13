import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/presentation/widget/beer_details_container.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/model/beer_details.dart';

class BeerDetailsScreen extends StatelessWidget{
  final BeerDetails beerModel;
  final int index;
  final Color color;

  const BeerDetailsScreen({super.key, required this.beerModel,required this.index,required this.color});

  @override
  Widget build(BuildContext context) {
    return TopWidget(
      title: 'Beer Details',
      bgColor: color,
      child: Stack(
        children: [
          buildTopView(),
          Align(
              alignment: Alignment.bottomCenter,
              child: BeerDetailsContainer(beerModel: beerModel,)),
          Positioned(
              right: 0,
              top: 130,
            child: beerModel.imageUrl!=null ? Hero(tag: 'BeerImage$index',child: CachedNetworkImage(height: 250,width:150,imageUrl:beerModel.imageUrl!,placeholder: (context, url) => Center(child: CircularProgressIndicator()),)):SizedBox(),)
        ],
      ),
    );
  }

  Column buildTopView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 25),
          child: Text(
            beerModel.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyle(
              Colors.white,
              'Anta-Regular',
              22,FontWeight.normal
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(onPressed: () {}, child: const Text("975 p")),
        ),
      ],
    );
  }

}
