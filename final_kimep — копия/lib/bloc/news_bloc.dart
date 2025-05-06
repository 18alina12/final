import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    try {
      // Simulated delay and mock data
      await Future.delayed(Duration(seconds: 1));

      final newsList = [
        'Breaking: Flutter 4 Released!',
        'Top 10 Dart Tips',
        'Understanding BLoC Better'
      ];

      emit(NewsLoaded(newsList: newsList));
    } catch (_) {
      emit(NewsError(message: 'Failed to load news'));
    }
  }
}
