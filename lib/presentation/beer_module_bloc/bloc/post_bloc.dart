import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_event.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_state.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/model/beer_details.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/repository/beer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final BeerListRepository _repository;
  final List<BeerDetails> _beerList = [];
  PostBloc(this._repository) : super(LoadingState()) {
    on<LoadedEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final beerList = await _repository.getBeerList(event.page);
        _beerList.addAll(beerList);
        emit(SuccessState(_beerList));
      } catch (e) {
        emit(FailureState(e.toString()));
      }
    });
  }
}
