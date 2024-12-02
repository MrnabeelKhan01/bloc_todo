import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../infrastructure/models/profile.dart';
import '../../infrastructure/services/profile.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    ///Get Profile Bloc
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final tasks = await ProfileServices().getUserProfile();
        emit(ProfileLoaded(tasks));
      } catch (e) {
        emit(ProfileFailed(e.toString()));
      }
    });
    /// Get Edit Profile Bloc
    on<EditProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        await ProfileServices().editUserProfile(
          name: event.name
        );
        emit(EditProfile());
      } catch (e) {
        emit(ProfileFailed(e.toString()));
      }
    });
  }
}
