import 'dart:math';

import 'package:first_flutter_demo_app/Model/beer_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui_helper/common_style.dart';

class BeerCard extends StatelessWidget{
  final BeerDetails beerDetails;
  BeerCard({super.key, required this.beerDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(25),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          borderRadius:
          BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                beerDetails.name??"",
                style: textStyle(
                    Colors.white,
                    'Anta-Regular',
                    22,
                    FontWeight.normal),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'italy, 13.5%',
              style: textStyle(
                  Colors.white,
                  'Anta-Regular',
                  22,
                  FontWeight.normal),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text("975 p")),
          ],
        ),
      ),
    );
  }

}