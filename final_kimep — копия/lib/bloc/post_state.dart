abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<String> posts;

  PostLoaded({required this.posts});
}

class PostAdded extends PostState {
  final bool success;

  PostAdded({required this.success});
}
