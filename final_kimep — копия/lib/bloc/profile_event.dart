import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String username;

  const UpdateProfile(this.username);

  @override
  List<Object> get props => [username];
}
