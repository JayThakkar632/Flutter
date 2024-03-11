import '../data/model/beer_details.dart';

abstract class PostEvent{}
class LoadingEvent extends PostEvent{}
class LoadedEvent extends PostEvent{
  final List<BeerDetails> beerList;
  LoadedEvent(this.beerList);
}
class ErrorEvent extends PostEvent{
  final String error;
  ErrorEvent(this.error);
}