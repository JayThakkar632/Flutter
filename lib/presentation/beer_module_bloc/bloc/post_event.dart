
abstract class PostEvent{}
class LoadedEvent extends PostEvent{
  String searchedText;
  String foodSearch;
  String brewedBefore;
  String brewedAfter;
  LoadedEvent({this.searchedText='',this.foodSearch='',this.brewedBefore='',this.brewedAfter=''});
}

class LoadMoreEvent extends PostEvent{}


