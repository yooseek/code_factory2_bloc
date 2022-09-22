import 'package:code_factory2_bloc/common/const/color.dart';
import 'package:code_factory2_bloc/common/model/response_model.dart';
import 'package:code_factory2_bloc/restaurant/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:code_factory2_bloc/restaurant/component/restaurant_card.dart';
import 'package:code_factory2_bloc/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantBloc,RestaurantState>(
      listener: (context, state) {
        if(state.response is CursorPaginationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('에러 발생')),
          );
        }
      },
      builder: <RestaurantState>(context, state) {
        final restaurantModel = state.response;
        if(restaurantModel is !CursorPagination<RestaurantModel>){
          return Container();
        }

        final model = restaurantModel.data;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // 아래와 같은 역할
                  // context.go('/restaurant/${model.id}');

                  context.goNamed(
                    'restaurantDetail',
                    params: {'rid': model[index].id},
                  );
                },
                child: RestaurantCard.fromModel(model: model[index]),
              );
            },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: BODY_TEXT_COLOR,
                    thickness: 2.0,
                  ),
                );
              },
              itemCount: model.length,
          ),
        );
      },
    );
  }
}
