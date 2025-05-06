part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class Authenticated extends AuthState {
  final String email;

  const Authenticated({required this.email});

  @override
  List<Object> get props => [email];
}

class Unauthenticated extends AuthState {
  final String? message;

  const Unauthenticated({this.message});

  @override
  List<Object> get props => [message ?? ''];
}
