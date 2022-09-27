import 'package:code_factory2_bloc/common/model/pagination_params.dart';
import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/core/usecases/usecase.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_model.dart';
import 'package:code_factory2_bloc/restaurant/respository/restaurant_repository.dart';

class GetRestaurantList implements UseCase<CursorPagination<RestaurantModel>,PaginationParams?>{
  final RestaurantRepository repository;

  // http://127.0.0.1:3000/restaurant/
  // http://127.0.0.1:3000/restaurant/{id}

  const GetRestaurantList(this.repository);

  // @override
  Future<CursorPagination<RestaurantModel>> paginate(PaginationParams? paginationParams) async {
    return await repository.paginate(paginationParams: paginationParams);
  }
}
