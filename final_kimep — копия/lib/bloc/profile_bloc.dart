import 'package:flutter/foundation.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final String username;
  ProfileLoadSuccess(this.username);
}

class ProfileLoadFailure extends ProfileState {
  final String error;
  ProfileLoadFailure(this.error);
}

class ProfileBloc extends ValueNotifier<ProfileState> {
  String _username = 'JohnDoe';

  ProfileBloc() : super(ProfileInitial());

  void load() {
    value = ProfileLoadInProgress();
    Future.delayed(const Duration(seconds: 1), () {
      value = ProfileLoadSuccess(_username);
    });
  }

  void update(String username) {
    value = ProfileLoadInProgress();
    Future.delayed(const Duration(milliseconds: 500), () {
      _username = username;
      value = ProfileLoadSuccess(_username);
    });
  }
}
