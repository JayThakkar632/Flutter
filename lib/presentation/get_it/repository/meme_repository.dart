import 'dart:convert';
import 'package:first_flutter_demo_app/presentation/get_it/repository/api.dart';

import '../model/meme.dart';
class MemeRepo{
  API api = API();
  Future<Meme> getMeme() async{
    var res = await api.sendRequest.get('/meme');
    Map<String,dynamic> meme=jsonDecode(res.data);
    return Meme.fromJson(meme);
  }
}