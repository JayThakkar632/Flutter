import 'package:first_flutter_demo_app/pojo/BeerDetails.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BeerDetailsScreen extends StatelessWidget {
  final BeerDetails beer;

  const BeerDetailsScreen({super.key, required this.beer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            )),
        title: Text(
          beer.tagline!,
          style: toolBarTitle(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.phone,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          buildTopView(),
          Align(
              alignment: Alignment.bottomCenter,
              child: buildBottomView(context)),
          Positioned(
              right: 0,
              top: 130,
              child: Image.network(
                beer.imageUrl!,
                height: 200,
                width: 150,
              )),
        ],
      ),
    );
  }

  Column buildTopView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 25),
          child: Text(
            beer.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyle(
              Colors.white,
              'Anta-Regular',
              22,
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

  SingleChildScrollView buildBottomView(BuildContext context) {
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
                            "${beer.volume!.value.toString()} ${beer.volume?.unit!}")
                      ]),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Abv."),
                        Text(beer.abv.toString())
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
                beer.description!,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 55,
                child: roundedElevatedButton(
                    'Add to cart', Colors.black, () async {}, 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
