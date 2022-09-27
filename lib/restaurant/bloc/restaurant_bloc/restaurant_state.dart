part of 'restaurant_bloc.dart';


class RestaurantState extends Equatable {
  final CursorPaginationBase response;

  const RestaurantState({
    required this.response,
  });

  factory RestaurantState.initial() {
    return RestaurantState(response: CursorPaginationLoading());
  }

  RestaurantState copyWith({
    CursorPaginationBase? response,
  }) {
    return RestaurantState(
      response: response ?? this.response,
    );
  }

  @override
  List<Object> get props => [response];
}
