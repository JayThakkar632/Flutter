import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_event.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_state.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/repository/beer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final BeerListRepository _repository;
  PostBloc(this._repository) : super(LoadingState()) {
    on<LoadedEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final beerList = await _repository.getBeerList();
        emit(SuccessState(beerList));
      } catch (e) {
        emit(FailureState(e.toString()));
      }
    });
  }
}
