import 'package:code_factory2_bloc/common/dio/dio_interceptor.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioRepository {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  const DioRepository({
    required this.dio,
    required this.secureStorage,
  });

  Dio get getDio => dio;

  @override
  List<Object> get props => [dio, secureStorage];

  void addInterceptor(UserModelBloc userModelBloc) {
    dio.interceptors.add(CustomInterceptor(
        storage: secureStorage, userModelBloc: userModelBloc));
  }
}
