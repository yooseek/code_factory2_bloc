import 'package:code_factory2_bloc/common/model/pagination_params.dart';
import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository{
  // http://127.0.0.1:3000/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
  _RestaurantRepository;

  // http://127.0.0.1:3000/restaurant/
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestaurantModel>> paginate({
    // retrofit 에서의 쿼리 추가
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // http://127.0.0.1:3000/restaurant/{id}
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
  });
}
