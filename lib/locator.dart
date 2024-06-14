import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_app/core/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt Locator = GetIt.asNewInstance();
Future<void> setUp() async {
  final dio = Dio();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  Locator.registerLazySingleton(() => dio);
  Locator.registerLazySingleton(() => AuthService());
  Locator.registerLazySingleton(() => ImagePicker());
  Locator.registerLazySingleton(() => sharedPreferences);
  // Locator.registerLazySingleton(() => SharePref);
}
