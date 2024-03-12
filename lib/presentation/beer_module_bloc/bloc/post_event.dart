abstract class PostEvent{}
class LoadedEvent extends PostEvent{
  final int page;
  LoadedEvent(this.page);
}

