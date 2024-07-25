import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../model/profile_model.dart';
import '../../services/services.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService _services;

  ProfileBloc(this._services) : super(const ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await _services.fetchProfile();
        emit(ProfileLoadedState(profileFromJson(profile)));
      } catch (e) {
        emit(ProfileErrorState('Failed to load profile: $e'));
      }
    });
  }
}