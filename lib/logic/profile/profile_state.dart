part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;
  const ProfileLoadedState(this.profile);
}

class ProfileErrorState extends ProfileState {
  final String error;
  ProfileErrorState(this.error);
}