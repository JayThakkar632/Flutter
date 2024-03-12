import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/beer_details.dart';

class BeerListRepository {
  Future<List<BeerDetails>>getBeerList(int page) async{
    String url='https://api.punkapi.com/v2/beers?page=$page&per_page=10';
    http.Response response =await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      List<dynamic> decodedData = json.decode(response.body);
      return  List<BeerDetails>.from(decodedData.map((data) => BeerDetails.fromJson(data)));
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}