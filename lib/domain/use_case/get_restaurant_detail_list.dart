
import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/core/usecases/usecase.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_model.dart';
import 'package:code_factory2_bloc/restaurant/respository/restaurant_repository.dart';

class GetRestaurantDetailList implements UseCase<CursorPagination<RestaurantModel>,String>{
  final RestaurantRepository repository;

  // http://127.0.0.1:3000/restaurant/
  // http://127.0.0.1:3000/restaurant/{id}

  const GetRestaurantDetailList(this.repository);

  Future<RestaurantDetailModel> getDetail(String id) async {
    return await repository.getRestaurantDetail(id: id);
  }
}
