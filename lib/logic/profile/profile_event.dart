part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {
  final String userId;

  LoadProfileEvent(this.userId);
}

class UpdateProfileImageEvent extends ProfileEvent {
  final String userId;
  final String imageUrl;

  UpdateProfileImageEvent(this.userId, this.imageUrl);
}

class UpdateProfileEvent extends ProfileEvent {
  final String userId;
  final String newName;

  UpdateProfileEvent(this.userId, this.newName);
}
