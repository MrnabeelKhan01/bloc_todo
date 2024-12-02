part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel model;

  ProfileLoaded(this.model);
}

final class EditProfile extends ProfileState {
  EditProfile();
}

final class ProfileFailed extends ProfileState {
  final String message;

  ProfileFailed(this.message);
}
