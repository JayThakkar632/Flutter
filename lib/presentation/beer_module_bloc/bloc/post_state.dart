import '../data/model/beer_details.dart';

abstract class PostState{
  final List<BeerDetails>posts;
  PostState(this.posts);
}

class InitState extends PostState{
  InitState(super.posts);
}

class LoadingState extends PostState{
  LoadingState(super.posts);
}
class SuccessState extends PostState{
  SuccessState({required posts}) : super(posts);
}
class FailureState extends PostState{
  String error;
  FailureState(super.posts, {required this.error});
}
