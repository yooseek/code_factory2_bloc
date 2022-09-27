import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'secure_storage_event.dart';

class SecureStorageBloc extends Bloc<SecureStorageEvent, FlutterSecureStorage> {
  SecureStorageBloc() : super(const FlutterSecureStorage()) {
    on<SecureStorageEvent>((event, emit) {
    });
  }
}
