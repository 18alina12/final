import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../app_text_styles.dart';

// Модель поста
class Post {
  final String title;
  final String body;

  Post({required this.title, required this.body});
}

// Состояния
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadInProgress extends PostState {}

class PostLoadSuccess extends PostState {
  final Post post;
  PostLoadSuccess({required this.post});
}

class PostLoadFailure extends PostState {
  final String error;
  PostLoadFailure(this.error);
}

// Управление логикой и состоянием через ValueNotifier
class PostNotifier extends ValueNotifier<PostState> {
  PostNotifier() : super(PostInitial());

  void load() {
    value = PostLoadInProgress();

    Future.delayed(const Duration(seconds: 1), () {
      try {
        final post = Post(
          title: 'Sample Post Title',
          body: 'This is the body of the post, loaded locally.',
        );
        value = PostLoadSuccess(post: post);
      } catch (e) {
        value = PostLoadFailure('Failed to load post');
      }
    });
  }
}

// UI страница
class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late final PostNotifier _postNotifier;

  @override
  void initState() {
    super.initState();
    _postNotifier = PostNotifier();
    _postNotifier.load();
  }

  @override
  void dispose() {
    _postNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('post'.tr()),
      ),
      body: ValueListenableBuilder<PostState>(
        valueListenable: _postNotifier,
        builder: (context, state, _) {
          if (state is PostLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.post.title, style: AppTextStyles.headline),
                  const SizedBox(height: 10),
                  Text(state.post.body, style: AppTextStyles.body),
                ],
              ),
            );
          } else if (state is PostLoadFailure) {
            return Center(child: Text(state.error.tr()));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
