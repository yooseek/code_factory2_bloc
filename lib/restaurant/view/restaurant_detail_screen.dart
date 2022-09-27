import 'package:badges/badges.dart';
import 'package:code_factory2_bloc/common/const/color.dart';
import 'package:code_factory2_bloc/common/layout/default_layout.dart';
import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/product/component/product_card.dart';
import 'package:code_factory2_bloc/restaurant/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:code_factory2_bloc/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:collection/collection.dart';

import '../model/restaurant_detail_model.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String id;

  const RestaurantDetailScreen({required this.id,Key? key}) : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<RestaurantBloc>().add(RestaurantGetDetail(id: widget.id));

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치면
    // 새로운 데이터를 추가 요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {

    }
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(restaurantDetailProvider(widget.id));
    // final ratingState = ref.watch(ratingProvider(widget.id));
    // final basketState = ref.watch(basketProvider);

    final state = context.watch<RestaurantBloc>().state.response;

    if(state is! CursorPagination){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final data = state.data.firstWhereOrNull((element) => element.id == widget.id);
    if(data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return DefaultLayout(
      title: data.name,
      // floatingActionButton 에 뱃지 사용하기
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // context.pushNamed(BasketScreen.routeName);
      //   },
      //   backgroundColor: PRIMARY_COLOR,
      //   child: Badge(
      //     // 언제 뱃지를 보여줄꺼냐
      //     showBadge: basketState.isNotEmpty,
      //     // 뱃지 카운트 내용
      //     badgeContent: Text(
      //       basketState
      //           .fold<int>(0,
      //               (previousValue, element) => previousValue + element.count)
      //           .toString(),
      //       style: TextStyle(
      //         color: PRIMARY_COLOR,
      //         fontSize: 10.0,
      //       ),
      //     ),
      //     // 뱃지 위치
      //     position: BadgePosition(top: - 16,end: -16),
      //     child: Icon(Icons.shopping_basket_outlined),
      //     badgeColor: Colors.white,
      //   ),
      // ),
      child:
      // 두 개의 리스트가 존재하고 대신 하나의 리스트처럼 움직이고 싶을 때
      CustomScrollView(
        controller: controller,
        slivers: [
          // 일반 위젯을 sliver 형태로 넣을 때
          SliverToBoxAdapter(
            child: RestaurantCard.fromModel(model: data, isDetail: true),
          ),

          // 디테일 정보가 로딩 중일 때
          if (data is! RestaurantDetailModel) renderLoading(),
          if (data is RestaurantDetailModel)
          // 일반 위젯을 sliver 형태로 넣을 때 - Label
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '메뉴',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),

          if (data is RestaurantDetailModel)
          // List 할 위젯을 sliver 형태로 넣을 때
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final model = data.products[index];

                    return InkWell(
                      onTap: () {
                        // ref.read(basketProvider.notifier).addToBasket(
                        //   product: ProductModel(
                        //       id: model.id,
                        //       name: model.name,
                        //       detail: model.detail,
                        //       imgUrl: model.imgUrl,
                        //       price: model.price,
                        //       restaurant: state),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ProductCard.fromRestaurantProductModel(
                            model: model),
                      ),
                    );
                  },
                  childCount: data.products.length,
                ),
              ),
            ),
          // if (ratingState is CursorPagination<RatingModel>)
          //   renderRatings(models: ratingState.data),
        ],
      ),
    );
  }

  // 로딩 중에 로딩표시 보여주기 - skeletons
  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            4,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  // 몇 줄 짜리로 보여줄껀지
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // SliverPadding renderRatings({required List<RatingModel> models}) {
  //   return SliverPadding(
  //     padding: EdgeInsets.all(
  //       16.0,
  //     ),
  //     sliver: SliverList(
  //       delegate: SliverChildBuilderDelegate(
  //             (context, index) {
  //           return Padding(
  //               padding: EdgeInsets.only(
  //                 bottom: 8.0,
  //               ),
  //               child: RatingCard.fromModel(entities: models[index]));
  //         },
  //         childCount: models.length,
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    super.dispose();
  }
}
