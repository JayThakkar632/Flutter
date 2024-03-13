
abstract class PostEvent{}
class LoadedEvent extends PostEvent{
  String searchedText;
  LoadedEvent({this.searchedText=''});
}

class LoadMoreEvent extends PostEvent{}

