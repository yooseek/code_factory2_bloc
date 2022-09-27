import 'package:code_factory2_bloc/common/model/pagination_params.dart';
import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_model.dart';

abstract class RestaurantRepositoryImpl {
  Future<CursorPagination<RestaurantModel>> paginate({
    PaginationParams? paginationParams,
  });

  Future<RestaurantDetailModel> getRestaurantDetail({
    required String id,
  });
}