import 'package:first_flutter_demo_app/bloc/data/model/beer_details.dart';
import 'package:first_flutter_demo_app/bloc/data/repository/post_beer_list_repository.dart';
import 'package:first_flutter_demo_app/bloc/logic/post_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PostCubit extends Cubit<PostState>{
  PostCubit():super(PostLoadingState()){
    getBeerList();
  }


  PostBeerListRepository postBeerListRepository= PostBeerListRepository();

  void getBeerList() async {
    try{
      List<BeerDetails> beerList= await postBeerListRepository.getBeerList();
      emit(PostLoadedState(beerList));
    }catch(e){
      emit(PostErrorState(e.toString()));
    }
  }


}