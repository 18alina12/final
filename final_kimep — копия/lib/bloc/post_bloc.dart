import 'dart:async';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc {
  final _stateController = StreamController<PostState>();
  final _eventController = StreamController<PostEvent>();

  Stream<PostState> get state => _stateController.stream;
  Sink<PostEvent> get eventSink => _eventController.sink;

  PostBloc() {
    _eventController.stream.listen(_mapEventToState);
    _stateController.add(PostInitial());
  }

  void _mapEventToState(PostEvent event) async {
    if (event is LoadPosts) {
      _stateController.add(PostLoading());
      await Future.delayed(Duration(seconds: 1)); // mock loading
      _stateController.add(PostLoaded(posts: ['Post A', 'Post B']));
    } else if (event is AddPost) {
      _stateController.add(PostLoading());
      await Future.delayed(Duration(seconds: 1)); // mock adding
      _stateController.add(PostAdded(success: true));
    }
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
