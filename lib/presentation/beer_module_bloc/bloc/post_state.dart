import '../data/model/beer_details.dart';

abstract class PostState{
  final List<BeerDetails>posts;
  PostState(this.posts);
}

class LoadingState extends PostState{
  LoadingState(super.posts);
}
class SuccessState extends PostState{
  SuccessState({required posts}) : super(posts);
}
class FailureState extends PostState{
  final String error;
  FailureState(this.error,super.posts);
}
