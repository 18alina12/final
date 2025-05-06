abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class AddPost extends PostEvent {
  final String content;

  AddPost(this.content);
}
