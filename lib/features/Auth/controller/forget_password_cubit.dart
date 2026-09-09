import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository _authRepository;

  ForgetPasswordCubit(this._authRepository) : super(ForgetPasswordInitial());

  Future<void> sendResetLink({required String email}) async {
    if (email.trim().isEmpty) {
      emit(const ForgetPasswordFailure('Please enter your email.'));
      return;
    }

    emit(ForgetPasswordLoading());
    try {
      await _authRepository.forgetPassword(email: email.trim());
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}