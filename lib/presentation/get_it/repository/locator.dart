import 'package:first_flutter_demo_app/presentation/check_internet_connectivity/bloc/internet_bloc.dart';
import 'package:first_flutter_demo_app/presentation/get_it/repository/meme_repository.dart';
import 'package:get_it/get_it.dart';
final locator=GetIt.instance;

void setUp(){
  locator.registerLazySingleton(() => MemeRepo());
  locator.registerLazySingleton(() => InternetBloc());
}
