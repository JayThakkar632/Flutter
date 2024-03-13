import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/beer_details.dart';
import 'package:dio/dio.dart';

import 'api/api.dart';

class BeerListRepository {
  API api = API();

  getBeerList(int page,String searchedText) async{
    String url='';
    url = '?page=$page&per_page=10';
    url+=searchedText.isNotEmpty ? '&beer_name=$searchedText' :'';
    try{
     var res= await api.sendRequest.get(url);
      if(res.statusCode == 200){
        if (res.data is List) {
          return (res.data as List<dynamic>).map((data) => BeerDetails.fromJson(data)).toList();
        } else {
          // If res.data is a JSON string, decode it
          List<dynamic> decodedData = json.decode(res.data);
          return decodedData.map((data) => BeerDetails.fromJson(data)).toList();
        }
        // List<dynamic> decodedData = json.decode(res.data);
        // return decodedData.map((data) => BeerDetails.fromJson(data)).toList();
      }
    }catch(e){
        throw e;
    }
  }
  // getBeerList(int page,String searchedText) async {
  //   String url='';
  //   url = 'https://api.punkapi.com/v2/beers?page=$page&per_page=10';
  //   url+=searchedText.isNotEmpty ? '&beer_name=$searchedText' :'';
  //   var response = await http.get(Uri.parse(url));
  //   if(response.statusCode == 200){
  //     List<dynamic> decodedData = json.decode(response.body);
  //     return  List<BeerDetails>.from(decodedData.map((data) => BeerDetails.fromJson(data)));
  //   }else{
  //     throw Exception(response.reasonPhrase);
  //   }
  // }
}