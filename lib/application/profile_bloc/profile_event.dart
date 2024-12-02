part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();
}

class EditProfileEvent extends ProfileEvent {
  final String name;

  EditProfileEvent({
    required this.name,
  });
}
