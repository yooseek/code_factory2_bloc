part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLogout extends AuthEvent {}
