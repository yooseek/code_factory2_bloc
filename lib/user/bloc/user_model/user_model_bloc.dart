import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:code_factory2_bloc/common/const/data.dart';
import 'package:code_factory2_bloc/common/secure_storage/secure_storage_bloc.dart';
import 'package:code_factory2_bloc/common/utils/data_utils.dart';
import 'package:code_factory2_bloc/user/model/user_model.dart';
import 'package:code_factory2_bloc/user/repository/auth_repository.dart';
import 'package:code_factory2_bloc/user/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'user_model_event.dart';
part 'user_model_state.dart';

class UserModelBloc extends Bloc<UserModelEvent, UserModelState> {
  final FlutterSecureStorage secureStorage;
  final UserMeRepository repository;
  final AuthRepository authRepository;

  UserModelBloc({
    required this.secureStorage,
    required this.repository,
    required this.authRepository,
  }) : super(UserModelState.initial()) {
    on<UserModelGetMe>(getMe, transformer: droppable());
    on<UserModelLogin>(login);
    on<UserModelLogout>(logout);
  }

  Future<void> getMe(event, emit) async {
    print('체크됨 ${event}');

    final accessToken = await secureStorage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await secureStorage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      emit(state.copyWith(userModel: null));
      return;
    }

    try {
      final response = await repository.getMe();
      emit(state.copyWith(userModel: response));
    } catch (e) {
      emit(state.copyWith(userModel: UserModelError(error: e.toString())));
    }
  }

  Future<void> login(UserModelLogin event, emit) async {
    emit(state.copyWith(userModel: UserModelLoading()));

    try {
      final response = await authRepository.login(
        username: event.username,
        password: event.password,
      );

      await secureStorage.write(
          key: REFRESH_TOKEN_KEY, value: response.refreshToken);
      await secureStorage.write(
          key: ACCESS_TOKEN_KEY, value: response.accessToken);

      final UserModel userResponse = await repository.getMe();

      emit(state.copyWith(userModel: userResponse));
    } catch (e) {
      emit(state.copyWith(userModel: UserModelError(error: '로그인에 실패했습니다.')));
    }
  }

  Future<void> logout(event, emit) async {
    emit(state.copyWith(userModel: null));

    await Future.wait([
      secureStorage.delete(key: REFRESH_TOKEN_KEY),
      secureStorage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}
