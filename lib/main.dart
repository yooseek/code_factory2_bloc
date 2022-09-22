import 'dart:async';

import 'package:code_factory2_bloc/common/bloc/go_router/go_router_bloc.dart';
import 'package:code_factory2_bloc/common/bloc/logger.dart';
import 'package:code_factory2_bloc/common/const/bloc_list.dart';
import 'package:code_factory2_bloc/common/const/data.dart';
import 'package:code_factory2_bloc/common/dio/dio_respository.dart';
import 'package:code_factory2_bloc/common/secure_storage/secure_storage_repository.dart';
import 'package:code_factory2_bloc/restaurant/respository/restaurant_repository.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:code_factory2_bloc/user/repository/auth_repository.dart';
import 'package:code_factory2_bloc/user/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  Bloc.observer = Logger();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SecureStorageRepository>(
          create: (context) => const SecureStorageRepository(
            flutterSecureStorage: FlutterSecureStorage(),
          ),
        ),
        RepositoryProvider<DioRepository>(
          create: (context) => DioRepository(
            dio: Dio(),
            secureStorage: context.read<SecureStorageRepository>().storage,
          ),
        ),
        RepositoryProvider<UserMeRepository>(
          create: (context) => UserMeRepository(
            baseUrl: 'http://$ip/user/me',
            context.read<DioRepository>().getDio,
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            baseUrl: 'http://$ip/auth',
            dio: context.read<DioRepository>().getDio,
          ),
        ),
        RepositoryProvider<RestaurantRepository>(
          create: (context) => RestaurantRepository(
              context.read<DioRepository>().getDio,
              baseUrl: 'http://$ip/restaurant'),
        ),
      ],
      child: MultiBlocProvider(
        providers: blocList,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), //터치시 키보드 내리기
          child: Builder(
            builder: (context) {
              context.read<DioRepository>().addInterceptor(context.read<UserModelBloc>());
              final router = context.watch<GoRouterBloc>().state;

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(fontFamily: 'NotoSans'),
                routeInformationParser: router.routeInformationParser,
                routerDelegate: router.routerDelegate,
                routeInformationProvider: router.routeInformationProvider,
              );
            },
          ),
        ),
      ),
    );
  }
}
