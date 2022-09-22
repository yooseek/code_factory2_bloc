import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  final FlutterSecureStorage flutterSecureStorage;

  const SecureStorageRepository({
    required this.flutterSecureStorage,
  });

  FlutterSecureStorage get storage => flutterSecureStorage;

  @override
  List<Object> get props => [flutterSecureStorage];
}