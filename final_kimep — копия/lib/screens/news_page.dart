import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:animate_do/animate_do.dart';

import '../app_text_styles.dart';

// Модель поста
class Post {
  final String title;
  final String body;

  Post({required this.title, required this.body});
}

// Состояния
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadInProgress extends NewsState {}

class NewsLoadSuccess extends NewsState {
  final List<Post> posts;

  NewsLoadSuccess(this.posts);
}

class NewsLoadFailure extends NewsState {}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ValueNotifier<NewsState> _newsState = ValueNotifier(NewsInitial());

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  void _fetchNews() {
    _newsState.value = NewsLoadInProgress();
    Future.delayed(const Duration(seconds: 2), () {
      // Здесь можно заменить на реальные данные
      final posts = List.generate(
        5,
        (index) => Post(
          title: 'News Title $index',
          body: 'This is the body of news item number $index.',
        ),
      );
      _newsState.value = NewsLoadSuccess(posts);
      // В случае ошибки: _newsState.value = NewsLoadFailure();
    });
  }

  @override
  void dispose() {
    _newsState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('news'.tr()),
      ),
      body: ValueListenableBuilder<NewsState>(
        valueListenable: _newsState,
        builder: (context, state, _) {
          if (state is NewsLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoadSuccess) {
            final posts = state.posts;
            return FadeIn(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    title: Text(post.title, style: AppTextStyles.body),
                    subtitle: Text(post.body, style: AppTextStyles.body),
                  );
                },
              ),
            );
          } else if (state is NewsLoadFailure) {
            return Center(child: Text('load_error'.tr()));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
