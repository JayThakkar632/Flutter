import 'package:first_flutter_demo_app/presentation/beer_module/beer_module_bloc/bloc/post_event.dart';
import 'package:first_flutter_demo_app/presentation/beer_module/beer_module_bloc/bloc/post_state.dart';
import 'package:first_flutter_demo_app/presentation/beer_module/beer_module_bloc/data/repository/beer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/beer_details.dart';

class PostBloc extends Bloc<PostEvent,PostState>{
  PostBloc():super(LoadingState()){

    BeerListRepository beerListRepository = BeerListRepository();

    void getBeerList() async {
      try{
        List<BeerDetails> beerList= await beerListRepository.getBeerList();
        on((event, emit) => emit(SuccessState(beerList)));
      }catch(e){
        on((event, emit) => emit(FailureState(beerList)));
      }
    }

    // on<LoadingEvent>((event, emit) => emit(LoadingState()));
    // on<LoadedEvent>((event, emit) => emit(SuccessState(event.beerList)));
    // on<ErrorEvent>((event, emit) => emit(FailureState("")));
  }
}
