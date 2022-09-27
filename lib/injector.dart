import 'package:code_factory2_bloc/common/const/data.dart';
import 'package:code_factory2_bloc/common/dio/dio_interceptor.dart';
import 'package:code_factory2_bloc/common/dio/dio_network.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:code_factory2_bloc/user/repository/auth_repository.dart';
import 'package:code_factory2_bloc/user/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  injector.registerLazySingleton<Dio>(
      () => Dio()..interceptors.add(CustomInterceptor(storage: injector())));

  injector.registerLazySingleton<UserMeRepository>(
      () => UserMeRepository(injector()));
  injector.registerLazySingleton<AuthRepository>(
      () => AuthRepository(baseUrl: 'http://$ip/auth', dio: injector()));
  injector.registerLazySingleton<UserModelBloc>(() => UserModelBloc(
      secureStorage: injector(),
      repository: injector(),
      authRepository: injector()));
}
