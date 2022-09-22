import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_factory2_bloc/common/model/pagination_params.dart';
import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_model.dart';
import 'package:code_factory2_bloc/restaurant/respository/restaurant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../common/model/model_with_id.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc({
    required this.repository,
  }) : super(RestaurantState.initial()) {
    _restaurantPaginate<RestaurantModel>(const RestaurantPaginate(), emit);
    on<RestaurantGetDetail>(_restaurantGetDetail);
    on<RestaurantPaginate>(_restaurantPaginate<RestaurantModel>);
  }

  Future<void> _restaurantPaginate<T extends IModelWithId>(RestaurantPaginate event, emit) async {
    try {
      // 5가지 상태
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3) CursorPaginationError - 에러가 있는 상태
      // 4) CursorPaginationRefetching - 첫 번째 페이지부터 다시 데이터를 가져올 때
      // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을 떄

      // 조건
      // 1) meta 안에 hasMore 가 false 일 때 (다음 데이터가 없을 때)
      if (state.response is CursorPagination && !event.forceRefetch) {
        final pState = state.response as CursorPagination;
        // 다음 데이터가 없으면 paginate는 더 이상 진행할 필요없음
        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 2) 로딩 중일 때 + fetchMore가 true일 때
      final isLoading = state.response is CursorPaginationLoading;
      final isRefetching = state.response is CursorPaginationRefetching;
      final isFetchingMore = state.response is CursorPaginationFetchingMore;
      // 로딩 중이면서 새로운 데이터를 추가로 또 요청하면 더 이상 진행할 필요없음
      if (event.fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      PaginationParams paginationParams = PaginationParams(count: event.fetchCount);

      // 3) 캐시가 되어진 후 데이터를 더 불러올 때 - fetchMore : true
      if (event.fetchMore) {
        final pState = state.response as CursorPagination<T>;

        emit(state.copyWith(response: CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        )));

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      // 4) 데이터를 처음부터 가져오는 상황
      else {
        // 만약 데이터가 있는 상황이라면 기존 데이터를 보존한채로 요청을 진행 - 새로고침
        if (state is CursorPagination && !event.forceRefetch) {
          final pState = state.response as CursorPagination<T>;

          emit(state.copyWith(response: CursorPaginationRefetching<T>(
              meta: pState.meta, data: pState.data)));
        } else {
          emit(state.copyWith(response:CursorPaginationLoading()));
        }
      }

      // 데이터 요청
      final response =
      await repository.paginate(paginationParams: paginationParams);

      // 데이터 요청 완료된 후처리
      if (state is CursorPaginationFetchingMore) {
        final pState = state.response as CursorPaginationFetchingMore<RestaurantModel>;

        emit(state.copyWith(response: response.copyWith(
          data: [...pState.data, ...response.data],
        )));
      } else {
        emit(state.copyWith(response:response));
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      emit(state.copyWith(response:CursorPaginationError(message: '데이터를 가져오는데 실패했습니다.')));
    }
  }

  Future<void> _restaurantGetDetail(RestaurantGetDetail event, emit) async {
    final id = event.id;
    final response = state.response;

    // 데이터가 하나도 없는 상태라면 - (CursorPagination) 이 아니라면
    if (response is! CursorPagination) {
      add(RestaurantPaginate());
    }

    // 다시 paginate를 했는데도 state가 CursorPaginantion 이 아니라면
    if (response is! CursorPagination) {
      return;
    }

    final pState = response as CursorPagination;

    final RestaurantDetailModel res =
        await repository.getRestaurantDetail(id: id);

    // restaurantModel은 없는데 restaurantDetailModel을 가져왔을 때
    // 그냥 뒤에 추가
    if (pState.data.where((element) => element.id == id).isEmpty) {
      emit(state.copyWith(response: pState.copyWith(data: <RestaurantModel>[
        ...pState.data,
        res,
      ])));
    } else {
      // 현재 pState는 restaurantModel,
      // 디테일을 한 번 불러오면 해당 restaurantModel을 restaurantDetailModel로 전환
      emit(state.copyWith(response: pState.copyWith(
        data: pState.data
            .map<RestaurantModel>(
              (e) => e.id == id ? res : e,
        )
            .toList(),
      )));
    }
  }
}
