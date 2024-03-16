import 'package:first_flutter_demo_app/presentation/retrofit/data/model/user_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiService {
  factory ApiService(Dio dio,{String baseUrl}) = _ApiService;


  @GET("/posts")
  Future<List<UserModel>> getData();
}