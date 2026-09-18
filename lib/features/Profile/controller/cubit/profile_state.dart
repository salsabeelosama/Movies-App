import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';
import 'package:movies_app/features/Profile/controller/cubit/profile_cubit.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> getProfile() async {
    try {
      emit(ProfileLoading());

      final data = await repository.getUserProfile();

      emit(
        ProfileSuccess(
          name: data['name'] ?? '',
          avatar: data['avatar'] ?? 'avatar1',
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}