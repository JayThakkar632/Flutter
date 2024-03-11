import '../data/model/beer_details.dart';

abstract class PostState{}
class LoadingState extends PostState{}
class SuccessState extends PostState{
  final List<BeerDetails> beerList;
  SuccessState(this.beerList);
}
class FailureState extends PostState{
  final String error;
  FailureState(this.error);
}
