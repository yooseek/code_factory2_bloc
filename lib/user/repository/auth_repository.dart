
import 'package:code_factory2_bloc/common/utils/data_utils.dart';
import 'package:code_factory2_bloc/user/model/login_response_model.dart';
import 'package:code_factory2_bloc/user/model/token_response_model.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  const AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    // 아이디 비번 인코딩
    // 토큰으로 생성
    final serialized = DataUtils.plainTobase64('$username:$password');

    // 헤더에 토큰 달고 api 요청
    final response = await dio.post(
      '$baseUrl/login',
      options: Options(headers: {
        'authorization': 'Basic $serialized',
      }),
    );

    return LoginResponse.fromJson(response.data);
  }

  Future<TokenResponse> token() async {
    final response = await dio.post(
      '$baseUrl/token',
      options: Options(headers: {'refreshToken': 'true'}),
    );

    return TokenResponse.fromJson(response.data);
  }
}
