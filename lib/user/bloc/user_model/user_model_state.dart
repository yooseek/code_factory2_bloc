part of 'user_model_bloc.dart';

class UserModelState extends Equatable {
  final UserModelBase? userModel;

  const UserModelState({
    required this.userModel,
  });

  factory UserModelState.initial() {
    return UserModelState(userModel: UserModelLoading());
  }

  UserModelState copyWith({
    UserModelBase? userModel,
  }) {
    return UserModelState(
      userModel: userModel,
    );
  }

  @override
  List<Object?> get props => [userModel];
}