import 'package:code_factory2_bloc/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'user_repository.g.dart';

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<UserModel> getMe();
}
