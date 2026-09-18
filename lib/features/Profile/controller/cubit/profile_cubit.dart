import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String name;
  final String avatar;

  ProfileSuccess({
    required this.name,
    required this.avatar,
  });
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

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