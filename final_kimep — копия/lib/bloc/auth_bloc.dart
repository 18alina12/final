import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthInitial());
    await Future.delayed(const Duration(seconds: 1));
    if (event.email == 'test@test.com' && event.password == 'password') {
      emit(Authenticated(email: event.email));
    } else {
      emit(const Unauthenticated(message: 'Invalid credentials'));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(const Unauthenticated());
  }
}
