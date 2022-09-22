import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_factory2_bloc/common/secure_storage/secure_storage_bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'dio_event.dart';
part 'dio_state.dart';

class DioBloc extends Bloc<DioEvent, Dio> {
  final SecureStorageBloc secureStorageBloc;

  DioBloc({required this.secureStorageBloc})
      : super(
          Dio()
            // ..interceptors.add(
            //   CustomInterceptor(
            //     storage: secureStorageBloc.state,
            //     userModelBloc: UserModelBloc(
            //       secureStorage: secureStorageBloc.state,
            //       repository: UserMeRepository(Dio()),
            //       authRepository: AuthRepository(baseUrl:'http://$ip/auth', dio: Dio()),
            //     ),
            //   ),
            // ),
        ) {
    on<DioEvent>((event, emit) {});
  }
}
