import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/Auth/register_cubit/register_state.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository repository;

  RegisterCubit(this.repository) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String avatar,
  }) async {
    try {
      emit(RegisterLoading());

      await repository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        avatar: avatar,
      );

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}