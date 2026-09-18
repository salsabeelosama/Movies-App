import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Auth/repository/auth_repository.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final AuthRepository repository;

  EditProfileCubit(this.repository) : super(EditProfileInitial());

  // Get current user data
  Future<void> getProfile() async {
    try {
      emit(EditProfileLoading());

      final data = await repository.getUserProfile();

      emit(
        EditProfileLoaded(
          name: data['name'] ?? '',
          phone: data['phone'] ?? '',
          avatar: data['avatar'] ?? 'avatar1',
        ),
      );
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  // Update user data
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    try {
      emit(EditProfileUpdating());

      await repository.updateUserProfile(
        name: name,
        phone: phone,
        avatar: avatar,
      );

      emit(EditProfileUpdated());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
  try {
    emit(EditProfileUpdating());

    await repository.deleteAccount();

    emit(EditProfileUpdated());
  } catch (e) {
    emit(EditProfileError(e.toString()));
  }
}
}