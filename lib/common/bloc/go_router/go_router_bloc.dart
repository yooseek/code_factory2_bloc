import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_factory2_bloc/common/view/root_tab.dart';
import 'package:code_factory2_bloc/common/view/splash_screen.dart';
import 'package:code_factory2_bloc/user/bloc/auth/auth_bloc.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:code_factory2_bloc/user/model/user_model.dart';
import 'package:code_factory2_bloc/user/view/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'go_router_event.dart';
part 'go_router_state.dart';

class GoRouterBloc extends Bloc<GoRouterEvent, GoRouter> {
  final AuthBloc authBloc;

  GoRouterBloc({required this.authBloc}) : super(GoRouter(
    routes: authBloc.routes,
    initialLocation: '/splash',
    refreshListenable: authBloc,
    redirect: authBloc.redirectLogic,
  )) {

    on<GoRouterInitial>((event,emit) {

    });
  }
}
