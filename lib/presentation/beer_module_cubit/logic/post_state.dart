
import '../data/model/beer_details.dart';

abstract class PostState{}

class PostLoadingState extends PostState{}

class PostLoadedState extends PostState{
  final List<BeerDetails> beerList;
  PostLoadedState(this.beerList);
}

class PostErrorState extends PostState{
  final String error;
  PostErrorState(this.error);
}