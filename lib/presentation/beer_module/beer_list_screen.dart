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
import '../../common_widget/text_form_field.dart';
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
  bool _isLoadingForData = false;
  ScrollController _scrollController = ScrollController();
  var _textFiledSearch = TextEditingController();
  var _searchingText = "";
  var _url="";
  var _foodName="";
  var _brewedBefore="";
  var _brewedAfter="";
  late http.Response response;

  @override
  void initState() {
    _isLoadingForData=true;
    _scrollController.addListener(scrolling);
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try{
      _page++;
      setState(() {
        Timer(const Duration(seconds: 2),(){
          _isLoading=true;
        });
      });
      _url='https://api.punkapi.com/v2/beers?page=$_page&per_page=10';
      if(_searchingText.isNotEmpty){
        _url+='&beer_name=$_searchingText';
      }
      if(_foodName.isNotEmpty){
        _url+='&food=$_foodName';
      }
      if(_brewedBefore.isNotEmpty){
        _url+='&brewed_before=$_brewedBefore';
      }
      if(_brewedAfter.isNotEmpty){
        _url+='&brewed_after=$_brewedAfter';
      }
      print(_url);
      // _searchingText.isEmpty ? _url= 'https://api.punkapi.com/v2/beers?page=$_page&per_page=10' : _url='https://api.punkapi.com/v2/beers?page=$_page&per_page=10&beer_name=$_searchingText';
      response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        setState(() {
          List<dynamic> decodedData = json.decode(response.body);
          List<BeerDetails> parsedBeers = List<BeerDetails>.from(
              decodedData.map((data) => BeerDetails.fromJson(data)));
          _searchingText.isNotEmpty ?  beers = [] : null;
          beers.addAll(parsedBeers);
          _isLoading = false;
          _isLoadingForSearch = false;
          _isLoadingForData = false;
        });
      } else {
        setState(() {
          _isLoading=false;
          _isLoadingForData=false;
        });
        showSnackBar("Invalid",context as BuildContext);
      }
    } on Exception catch(e){
      setState(() {
        _isLoading=false;
        _isLoadingForSearch=false;
        _isLoadingForData=false;
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.filter_alt),
          onPressed: () {
            showFilterDialog(context);
          },
        ),
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
                        _isLoadingForSearch=true;
                        _searchingText = value;
                        search(_searchingText);
                      },
                    ),
                    _isLoadingForSearch ? const Positioned(right: 10,
                      child: Align(alignment: Alignment.centerRight,
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : Container(),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 0, top: 20),
                    itemCount: beers.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      List<Color> colors = [Colors.blue, Colors.red, Colors.amberAccent,Colors.green,Colors.deepOrange];
                      var colorIndex=index%colors.length;
                      return index == beers.length ? const Center(child: CircularProgressIndicator()):GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BeerDetailsScreen(beerModel: beers[index],index: index,color:colors[colorIndex])));
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
                                      BeerCard(beerDetails: beers[index],color: colors[colorIndex]),
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
                    },
                  ),
                ),
                //LastOrder()
              ],
            ),
            _isLoadingForData ? const Center(child: CircularProgressIndicator()) : beers.isEmpty ? Center(child: Text('No data found',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)):SizedBox(),
          ],
        ),
      ),
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
          content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
              ),
              height: MediaQuery.sizeOf(context).height*0.31,
              width: MediaQuery.sizeOf(context).width*0.8,
              child: FilterDialog(
                onOkayCallback:(foodSearch,brewedBefore,brewedAfter){
                  beers=[];
                  _foodName=foodSearch;
                  _brewedBefore=brewedBefore;
                  _brewedAfter=brewedAfter;
                  getData();
                  Navigator.pop(context);
                },
                onResetCallBack: (){
                  _foodName='';
                  _brewedBefore='';
                  _brewedAfter='';
                  getData();
                  Navigator.pop(context);
                },foodSearch:_foodName,brewedAfter: _brewedAfter,brewedBefore: _brewedBefore,)
          ),
        );
      },
    );
  }
}


