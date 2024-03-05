import 'package:first_flutter_demo_app/presentation/beer_module/widget/beer_card.dart';
import 'dart:convert';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/beer_details.dart';
import '../../common_widget/appbar.dart';
import '../../common_widget/snack_bar.dart';
import 'beer_details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class BeerListScreen extends StatefulWidget {
  const BeerListScreen({super.key});

  @override
  State<BeerListScreen> createState() => _BeerListScreenState();
}

class _BeerListScreenState extends State<BeerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(title: "Beer", context: context),
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
  bool _isLoading = false;
  bool _isLoadingForSearch = false;
  ScrollController _scrollController = ScrollController();
  var _textFiledSearch = TextEditingController();
  var _searchingText = "";
  var _url="";
  late http.Response response;

  @override
  void initState() {
    _scrollController.addListener(scrolling);
    getData(_searchingText);
    super.initState();
  }

  Future<void> getData(String _text) async {
    try{
      _page++;
      setState(() {
        _isLoading = true;
      });
      _text.isEmpty ? _url= 'https://api.punkapi.com/v2/beers?page=$_page&per_page=10' : _url='https://api.punkapi.com/v2/beers?page=$_page&per_page=10&beer_name=$_text';
      response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        setState(() {
          List<dynamic> decodedData = json.decode(response.body);
          List<BeerDetails> parsedBeers = List<BeerDetails>.from(
              decodedData.map((data) => BeerDetails.fromJson(data)));
          _text.isNotEmpty ?  beers = [] : null;
          beers.addAll(parsedBeers);
          _isLoading = false;
          _isLoadingForSearch = false;
        });
      } else {
        showSnackBar("Invalid",context as BuildContext);
      }
    } on Exception catch(e){
      setState(() {
        _isLoading=false;
        _isLoadingForSearch=false;
      });
      showSnackBar(e.toString(), context);
    }
  }

  void scrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getData(_searchingText);
    }
  }

  void search(String text) {
    _page = 0;
    getData(text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                TextField(
                  controller: _textFiledSearch,
                  decoration: editText("Search here", 10.0, false),
                  onChanged: (value) {
                    _isLoadingForSearch=true;
                    _searchingText = value;
                    search(_searchingText);
                  },
                ),
                _isLoadingForSearch ? Positioned(right: 10,
                  child: Align(alignment: Alignment.centerRight,
                    child: CircularProgressIndicator(),
                  ),
                )
                    : Container(),
              ],
            ),
            Container(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 0, top: 20, bottom: 250),
                itemCount: beers.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  print("isLoading$_isLoading");
                  if (index == beers.length) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BeerDetailsScreen(beerModel: beers[index],index: index,)));
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
                                  BeerCard(beerDetails: beers[index],),
                                ]),
                            Positioned(
                                right: 25,
                                top: 15,
                                child: beers[index].imageUrl!=null ? Hero(tag:'BeerImage$index',child: CachedNetworkImage(height: 200,width:80,imageUrl:beers[index].imageUrl!,placeholder: (context, url) => Center(child: CircularProgressIndicator()),)):SizedBox(),)
                                // child: beers[index].imageUrl != null
                                //     ? Image.network(beers[index].imageUrl!,
                                //         height: 200)
                                //     : SizedBox())
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
    );
  }
}
