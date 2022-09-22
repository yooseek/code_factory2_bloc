part of 'user_model_bloc.dart';

@immutable
abstract class UserModelEvent extends Equatable {
  const UserModelEvent();

  @override
  List<Object> get props => [];
}

class UserModelGetMe extends UserModelEvent {
}

class UserModelLogin extends UserModelEvent {
  final String username;
  final String password;

  const UserModelLogin({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class UserModelLogout extends UserModelEvent {
}