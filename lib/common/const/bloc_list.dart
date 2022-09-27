import 'package:code_factory2_bloc/common/bloc/go_router/go_router_bloc.dart';
import 'package:code_factory2_bloc/common/secure_storage/secure_storage_repository.dart';
import 'package:code_factory2_bloc/restaurant/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:code_factory2_bloc/restaurant/respository/restaurant_repository.dart';
import 'package:code_factory2_bloc/user/bloc/auth/auth_bloc.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:code_factory2_bloc/user/repository/auth_repository.dart';
import 'package:code_factory2_bloc/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

List<BlocProviderSingleChildWidget> blocList = [
  BlocProvider<UserModelBloc>(
    create: (context) => UserModelBloc(
      secureStorage: context.read<SecureStorageRepository>().storage,
      // repository: UserMeRepository
      //   baseUrl: 'http://$ip/user/me',
      //   context.read<DioBloc>().state,
      // ),
      repository: context.read<UserMeRepository>(),
      authRepository: context.read<AuthRepository>(),
    )..add(UserModelGetMe()),
  ),
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(userModelBloc: context.read<UserModelBloc>()),
  ),
  BlocProvider<GoRouterBloc>(
    create: (context) => GoRouterBloc(authBloc: context.read<AuthBloc>()),
  ),
  BlocProvider<RestaurantBloc>(
    create: (context) =>
        RestaurantBloc(repository: context.read<RestaurantRepository>()),
  ),
];
