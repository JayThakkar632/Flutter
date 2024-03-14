import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_event.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_state.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/model/beer_details.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/repository/beer_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final BeerListRepository _repository;
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  PostBloc(this._repository) :super(LoadingState([])) {
    scrollController.addListener(() {
      add(LoadMoreEvent());
    });

    on<LoadedEvent>((event, emit) async {
      List<BeerDetails>posts;
      page = 1;
      isLoadingMore = false;
      try {
        posts = await _repository.getBeerList(
            page, event.searchedText, event.foodSearch, event.brewedBefore,
            event.brewedAfter);
        emit(SuccessState(posts: posts));
      }catch (e) {
        emit(FailureState([], error: e.toString()));
      }
    });

    on<LoadMoreEvent>((event, emit) async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        page++;
        final List<BeerDetails>posts;
        posts = await _repository.getBeerList(page, '', '', '', '');
        emit(SuccessState(posts: [...state.posts, ...posts]));
      }
    });
  }
}
