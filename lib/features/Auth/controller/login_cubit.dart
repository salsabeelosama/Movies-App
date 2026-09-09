import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      emit(const LoginFailure('Please enter your email and password.'));
      return;
    }

    emit(LoginLoading());
    try {
      final user = await _authRepository.login(
        email: email.trim(),
        password: password.trim(),
      );
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    try {
      final user = await _authRepository.loginWithGoogle();
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginInitial());
      }
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}