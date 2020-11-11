part of 'edit_profile_bloc.dart';

class EditProfileState {
  final bool isNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid;

  EditProfileState(
      {this.isNameValid,
        this.isSubmitting,
        this.isSuccess,
        this.isFailure});

  factory EditProfileState.initial() {
    return EditProfileState(
      isNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditProfileState.loading() {
    return EditProfileState(
      isNameValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditProfileState.failure() {
    return EditProfileState(
      isNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory EditProfileState.success() {
    return EditProfileState(
      isNameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  EditProfileState update({
    bool isNameValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  EditProfileState copyWith({
    bool isNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return EditProfileState(
      isNameValid: isNameValid ?? this.isNameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}