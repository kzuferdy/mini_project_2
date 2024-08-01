import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/profile_model.dart';
import '../../services/services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService _profileService;

  ProfileBloc(this._profileService) : super(ProfileLoading()) {
    on<LoadProfileEvent>(_onLoadProfileEvent);
    on<UpdateProfileImageEvent>(_onUpdateProfileImageEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
  }

  Future<void> _onLoadProfileEvent(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      // Jika pengguna belum ada di Firestore, tambahkan
      final doc = await _profileService.getProfile(event.userId);
      if (doc.isEmpty) {
        await _profileService.createUser(event.userId, 'First', 'Last');
      }

      final profile = await _profileService.getProfile(event.userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to load profile'));
    }
  }

  Future<void> _onUpdateProfileImageEvent(UpdateProfileImageEvent event, Emitter<ProfileState> emit) async {
    try {
      await _profileService.updateProfileImage(event.userId, event.imageUrl);
      final profile = await _profileService.getProfile(event.userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to update profile image'));
    }
  }

  Future<void> _onUpdateProfileEvent(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      await _profileService.updateProfileName(event.userId, event.newName);
      final profile = await _profileService.getProfile(event.userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to update profile name'));
    }
  }
}

