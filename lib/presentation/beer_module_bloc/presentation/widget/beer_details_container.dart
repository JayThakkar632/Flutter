import 'package:first_flutter_demo_app/common_widget/round_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/model/beer_details.dart';

class BeerDetailsContainer extends StatelessWidget{
  final BeerDetails beerModel;
  const BeerDetailsContainer({super.key, required this.beerModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.65,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Vol."),
                        Text(
                            "${beerModel.volume!.value.toString()} ${beerModel.volume?.unit!}")
                      ]),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Abv."),
                        Text(beerModel.abv.toString())
                      ]),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("Grape"),
              const Text("Tempranilho, 2015"),
              const SizedBox(
                height: 25,
              ),
              const Text("Region"),
              const Text("Spain, Ribera del\nDuero"),
              const SizedBox(
                height: 20,
              ),
              Text(
                beerModel.description!,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              RoundedElevatedButton(title: 'Add to cart',color: Colors.black,voidCallback: (){},width: MediaQuery.sizeOf(context).width,height: 55,)
            ],
          ),
        ),
      ),
    );
  }

}