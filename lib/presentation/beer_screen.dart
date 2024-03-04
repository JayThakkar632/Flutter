import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:first_flutter_demo_app/pojo/BeerDetails.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../common_widget/appbar.dart';
import 'beer_details_screen.dart';
import 'package:http/http.dart' as http;

var page = 0;
List<BeerDetails> beers = [];
bool isLoading = false;
ScrollController scrollController = ScrollController();
var textFiledSearch = TextEditingController();
var searchingText = "";
late http.Response response;

class BeerViewScreen extends StatefulWidget {
  const BeerViewScreen({super.key});

  @override
  State<BeerViewScreen> createState() => _BeerViewScreenState();
}

class _BeerViewScreenState extends State<BeerViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(title: "Beer", context: context),
      body: const AllWineDetails(),
    );
  }
}

class AllWineDetails extends StatefulWidget {
  const AllWineDetails({super.key});

  @override
  State<AllWineDetails> createState() => _AllWineDetailsState();
}

class _AllWineDetailsState extends State<AllWineDetails> {
  //textOverflow
  //screenUtils
  @override
  Widget build(BuildContext context) {
    return const TopBeerDetails();
  }
}

class TopBeerDetails extends StatefulWidget {
  const TopBeerDetails({super.key});

  @override
  State<TopBeerDetails> createState() => _TopBeerDetailsState();
}

class _TopBeerDetailsState extends State<TopBeerDetails> {
  @override
  void initState() {
    scrollController.addListener(scrolling);
    getData(searchingText);
    super.initState();
  }

  Future<void> getData(String text) async {

    page++;
    setState(() {
      isLoading = true;
    });

    if (text.isNotEmpty) {
      response = await http.get(Uri.parse(
          'https://api.punkapi.com/v2/beers?page=$page&per_page=10&beer_name=$text'));
    } else {
      response = await http.get(
          Uri.parse('https://api.punkapi.com/v2/beers?page=$page&per_page=10'));
    }
    //response = await http.get(Uri.parse(url);


    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> decodedData = json.decode(response.body);
        List<BeerDetails> parsedBeers = List<BeerDetails>.from(
            decodedData.map((data) => BeerDetails.fromJson(data)));
        beers.addAll(parsedBeers);
        isLoading = false;
        if (beers.isEmpty) {
          showSnackBar("no data found");
        }
      });
    } else {
      showSnackBar("Invalid");
    }
  }

  void scrolling() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      getData(searchingText);
    }
  }

  void search(String text) {
    page = 0;
    beers = [];
    getData(text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textFiledSearch,
                decoration: editText("Search here", 15.0, false),
                onChanged: (value) {
                  searchingText = value;
                  search(searchingText);
                },
              ),
              Container(
                height: MediaQuery.sizeOf(context).height,
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(left: 0, top: 20, bottom: 250),
                  itemCount: beers.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    print("isLoading$isLoading");
                    if (index == beers.length) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BeerDetailsScreen(beer: beers[index])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      height: 70,
                                      child: Text(
                                        beers[index].tagline!,
                                        style: textStyle(
                                            Colors.black,
                                            'Anta-Regular',
                                            22,
                                            FontWeight.bold),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Card(
                                      shadowColor: Colors.pinkAccent,
                                      elevation: 5,
                                      child: Container(
                                        padding: const EdgeInsets.all(25),
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                          color: Colors.pinkAccent,
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
                                                beers[index].name!,
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
                                  child: beers[index].imageUrl != null
                                      ? Image.network(beers[index].imageUrl!,
                                          height: 200)
                                      : SizedBox())
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),

              //LastOrder()
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String msg) {
    var snackBar = SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class LastOrder extends StatefulWidget {
  const LastOrder({super.key});

  @override
  State<LastOrder> createState() => _LastOrderState();
}

class _LastOrderState extends State<LastOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Last orders",
                style: textStyle(
                    Colors.black, 'Anta-Regular', 22, FontWeight.normal),
                textAlign: TextAlign.start,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "View all",
                    style: textStyle(
                        Colors.black, 'Anta-Regular', 18, FontWeight.normal),
                    textAlign: TextAlign.end,
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.black, // Adjust icon color as needed
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 250,
            width: MediaQuery.sizeOf(context).width,
            child: ListView.builder(
              itemCount: beers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 210,
                  height: 270,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 30),
                        child: Container(
                          width: 200,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              color: Colors.pinkAccent),
                        ),
                      ),
                      Column(
                        children: [
                          Image.network(
                            beers[index].imageUrl!,
                            height: 200,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              beers[index].name!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Positioned(
                          bottom: 0, right: 15, child: Icon(Icons.add_a_photo)),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
