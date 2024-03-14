import 'dart:convert';

import 'package:first_flutter_demo_app/model/user_details.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/exceptions/custom_exception.dart';

import 'api.dart';

class UserRepository {
  API api = API();
  getUserList() async {
    try {
      var res = await api.sendRequest.get('/posts');
      if (res.statusCode == 200) {
        if (res.data is List) {
          return (res.data as List<dynamic>)
              .map((data) => UserDetails.fromJson(data))
              .toList();
        } else {
          // If res.data is a JSON string, decode it
          List<dynamic> decodedData = json.decode(res.data);
          return decodedData.map((data) => UserDetails.fromJson(data)).toList();
        }
      } else if(res.statusCode == 401) {
        throw CustomException("Authentication Exception");
      }
    } catch (e) {
      throw Exception();
    }
  }
}
