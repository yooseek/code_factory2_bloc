import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_model.dart';
import 'package:code_factory2_bloc/restaurant/respository/restaurant_repository.dart';
import 'package:code_factory2_bloc/domain/use_case/get_restaurant_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {
}

void main() {
  GetRestaurantList usecase;
  MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = GetRestaurantList(mockRestaurantRepository);
  });

}