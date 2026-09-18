abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final String name;
  final String phone;
  final String avatar;

  EditProfileLoaded({
    required this.name,
    required this.phone,
    required this.avatar,
  });
}

class EditProfileUpdating extends EditProfileState {}

class EditProfileUpdated extends EditProfileState {}

class EditProfilePasswordResetSuccess extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;

  EditProfileError(this.message);
}