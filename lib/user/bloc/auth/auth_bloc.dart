import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:code_factory2_bloc/common/bloc/go_router/go_router_bloc.dart';
import 'package:code_factory2_bloc/common/view/root_tab.dart';
import 'package:code_factory2_bloc/common/view/splash_screen.dart';
import 'package:code_factory2_bloc/restaurant/view/restaurant_detail_screen.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:code_factory2_bloc/user/model/user_model.dart';
import 'package:code_factory2_bloc/user/view/login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  final UserModelBloc userModelBloc;
  late final StreamSubscription userModelSubscription;
  
  AuthBloc({required this.userModelBloc}) : super(AuthInitial()) {
    userModelSubscription = userModelBloc.stream.listen((event) {
      notifyListeners();
    });
    
    on<AuthLogout>(logout,
    transformer: droppable());
  }

  @override
  Future<void> close() {
    userModelSubscription.cancel();
    return super.close();
  }

  Future<void> logout(event, emit) async{
    userModelBloc.add(UserModelLogout());
  }

  List<GoRoute> get routes => [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const RootTab(),
      routes: [
        GoRoute(
          path: 'restaurant/:rid',
          name: 'restaurantDetail',
          builder: (context, state) => RestaurantDetailScreen(id: state.params['rid']!),
        ),
      ]
    ),
    GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen()),
    GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen()),
    // GoRoute(
    //     path: '/basket',
    //     name: BasketScreen.routeName,
    //     builder: (context, state) => BasketScreen()),
    // GoRoute(
    //     path: '/order_done',
    //     name: OrderDoneScreen.routeName,
    //     builder: (context, state) => OrderDoneScreen()),
  ];

  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = userModelBloc.state.userModel;

    final logging = state.location == '/login';

    // ?????? ????????? ????????? ????????? ?????????
    // ????????? ????????? ???????????? ??????
    // ?????? ????????? ?????? ???????????? ????????? ???????????? ??????
    if (user == null) {
      return logging ? null : '/login';
    }

    // ?????? ????????? ?????? ???
    if (user is UserModel) {
      // ????????? ???????????? ?????? ????????? splash ??????????????? ????????? ??????
      if (logging || state.location == '/splash') {
        return '/';
      } else {
        // ????????? ?????? ????????? ????????? ??????
        return null;
      }
    }

    if (user is UserModelError) {
      return !logging ? '/login' : null;
    }

    return null;
  }
}
