import 'package:first_flutter_demo_app/presentation/beer_module_cubit/logic/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/beer_details.dart';
import '../data/repository/post_beer_list_repository.dart';
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