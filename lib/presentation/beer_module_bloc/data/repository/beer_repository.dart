import 'dart:convert';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/exceptions/custom_exception.dart';

import '../model/beer_details.dart';
import 'api/api.dart';

class BeerListRepository {
  API api = API();
  getBeerList(int page, String searchedText, String foodSearch,
      String brewedBefore, String brewedAfter) async {
    String url = '';
    url = '?page=$page&per_page=10';
    url += searchedText.isNotEmpty ? '&beer_name=$searchedText' : '';
    url += foodSearch.isNotEmpty ? '&food=$foodSearch' : '';
    url += brewedBefore.isNotEmpty ? '&brewed_before=$brewedBefore' : '';
    url += brewedAfter.isNotEmpty ? '&brewed_after=$brewedAfter' : '';
    try{
      var res = await api.sendRequest.get(url);
      if(res.statusCode == 200){
        if (res.data is List) {
          return (res.data as List<dynamic>)
              .map((data) => BeerDetails.fromJson(data))
              .toList();
        } else {
          // If res.data is a JSON string, decode it
          List<dynamic> decodedData = json.decode(res.data);
          return decodedData.map((data) => BeerDetails.fromJson(data)).toList();
        }
      }
    }catch(e){
      throw CustomException("hello");
    }
  }

}
