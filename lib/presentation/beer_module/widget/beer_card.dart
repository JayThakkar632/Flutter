import 'dart:math';

import 'package:first_flutter_demo_app/Model/beer_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui_helper/common_style.dart';
import 'package:cached_network_image/cached_network_image.dart';


class BeerCard extends StatelessWidget{
  List<BeerDetails> beerDetails = [];
  int index;
  final Color color;

  BeerCard({super.key, required this.beerDetails,required this.color,required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: 200,
              height: 70,
              child: Text(
                beerDetails[index].tagline!,
                style: textStyle(
                    Colors.black, 'Anta-Regular', 22, FontWeight.bold),
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
           Card(
              shadowColor: color,
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(25),
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: color,
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
                        beerDetails[index].name??"",
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
            )
          ]),
          Positioned(
            right: 25,
            top: 15,
            child: beerDetails[index].imageUrl != null
                ? Hero(
                tag: 'BeerImage$index',
                child: CachedNetworkImage(
                  height: 200,
                  width: 80,
                  imageUrl: beerDetails[index].imageUrl!,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                ))
                : SizedBox(),
          )
        ],
      ),
    );
    // return Card(
    //   shadowColor: color,
    //   elevation: 5,
    //   child: Container(
    //     padding: const EdgeInsets.all(25),
    //     width: MediaQuery.sizeOf(context).width,
    //     decoration: BoxDecoration(
    //       color: color,
    //       borderRadius:
    //       BorderRadius.circular(12),
    //     ),
    //     child: Column(
    //       crossAxisAlignment:
    //       CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(
    //           width: 200,
    //           child: Text(
    //             beerDetails.name??"",
    //             style: textStyle(
    //                 Colors.white,
    //                 'Anta-Regular',
    //                 22,
    //                 FontWeight.normal),
    //             textAlign: TextAlign.start,
    //             maxLines: 1,
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           'italy, 13.5%',
    //           style: textStyle(
    //               Colors.white,
    //               'Anta-Regular',
    //               22,
    //               FontWeight.normal),
    //           textAlign: TextAlign.start,
    //         ),
    //         const SizedBox(
    //           height: 15,
    //         ),
    //         ElevatedButton(
    //             onPressed: () {},
    //             child: const Text("975 p")),
    //       ],
    //     ),
    //   ),
    // );
  }

}