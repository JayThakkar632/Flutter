import 'dart:async';

import 'package:first_flutter_demo_app/presentation/beer_module/widget/beer_card.dart';
import 'package:first_flutter_demo_app/presentation/beer_module/widget/filter/filter_dialog.dart';
import 'dart:convert';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../Model/beer_details.dart';
import '../../common_widget/appbar.dart';
import '../../common_widget/snack_bar.dart';
import 'beer_details_screen.dart';
import 'package:http/http.dart' as http;

class BeerListScreen extends StatefulWidget {
  const BeerListScreen({super.key});

  @override
  State<BeerListScreen> createState() => _BeerListScreenState();
}

class _BeerListScreenState extends State<BeerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Beer", context: context),
      body: const BeerDetailsList(),
    );
  }
}

class BeerDetailsList extends StatefulWidget {
  const BeerDetailsList({super.key});

  @override
  State<BeerDetailsList> createState() => _BeerDetailsListState();
}

class _BeerDetailsListState extends State<BeerDetailsList> {
  var _page = 0;
  List<BeerDetails> beers = [];
  bool isLoading = true;
  bool isLoadingForSearch = false;
  final ScrollController _scrollController = ScrollController();
  final _textFiledSearch = TextEditingController();
  var searchingText = "";
  var url = "";
  var foodName = "";
  var brewedBefore = "";
  var brewedAfter = "";
  late http.Response response;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrolling);
    getData();
  }

  Future<void> getData() async {
    try {
      _page++;
      setState(() {
        isLoading = true;
      });
      url = 'https://api.punkapi.com/v2/beers?page=$_page&per_page=10';
      if (searchingText.isNotEmpty) {
        url += '&beer_name=$searchingText';
      }
      if (foodName.isNotEmpty) {
        url += '&food=$foodName';
      }
      if (brewedBefore.isNotEmpty) {
        url += '&brewed_before=$brewedBefore';
      }
      if (brewedAfter.isNotEmpty) {
        url += '&brewed_after=$brewedAfter';
      }
      print(url);
      // _searchingText.isEmpty ? _url= 'https://api.punkapi.com/v2/beers?page=$_page&per_page=10' : _url='https://api.punkapi.com/v2/beers?page=$_page&per_page=10&beer_name=$_searchingText';
      response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          List<dynamic> decodedData = json.decode(response.body);
          List<BeerDetails> parsedBeers = List<BeerDetails>.from(
              decodedData.map((data) => BeerDetails.fromJson(data)));
          searchingText.isNotEmpty ? beers = [] : null;
          beers.addAll(parsedBeers);
          isLoading = false;
          isLoadingForSearch = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar("Invalid", context);
      }
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
        isLoadingForSearch = false;
      });
      showSnackBar(e.toString(), context);
    }
  }

  void scrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getData();
    }
  }

  void search(String text) {
    _page = 0;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    TextField(
                      controller: _textFiledSearch,
                      decoration: editText("Search here", 10.0, false),
                      onChanged: (value) {
                        isLoadingForSearch = true;
                        searchingText = value;
                        search(searchingText);
                      },
                    ),
                    isLoadingForSearch
                        ? const Positioned(
                            right: 10,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Expanded(
                  child: beers.isNotEmpty? ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 0, top: 20),
                    itemCount: beers.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      List<Color> colors = [
                        Colors.blue,
                        Colors.red,
                        Colors.amberAccent,
                        Colors.green,
                        Colors.deepOrange
                      ];
                      var colorIndex = index % colors.length;
                      return isLoading && index > beers.length-1 && _page != 1
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : buildGestureDetector(
                              context, index, colors, colorIndex);
                    },
                  ):const SizedBox(),
                ),
                //LastOrder()
              ],
            ),
            isLoading && beers.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : beers.isEmpty
                    ? Center(child: Text('No data found'))
                    : SizedBox()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.filter_alt),
          onPressed: () {
            showFilterDialog(context);
          },
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(
      BuildContext context, int index, List<Color> colors, int colorIndex) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BeerDetailsScreen(
                    beerModel: beers[index],
                    index: index,
                    color: colors[colorIndex])));
      },
      child:BeerCard(beerDetails: beers, color: colors[colorIndex],index:index)
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: const Center(child: Text('Choose your Filter')),
            content: FilterDialog(
              onOkayCallback: (foodSearch, brewedBefore, brewedAfter) {
                beers = [];
                foodName = foodSearch;
                this.brewedBefore = brewedBefore;
                this.brewedAfter = brewedAfter;
                getData();
                Navigator.pop(context);
              },
              onResetCallBack: () {
                beers = [];
                _page=0;
                foodName = '';
                brewedBefore = '';
                brewedAfter = '';
                getData();
                Navigator.pop(context);
              },
              foodSearch: foodName,
              brewedAfter: brewedAfter,
              brewedBefore: brewedBefore,
            ));
      },
    );
  }
}
