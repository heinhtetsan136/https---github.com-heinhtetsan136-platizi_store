import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_app/core/service/auth_service.dart';

GetIt Locator = GetIt.asNewInstance();
void setUp() {
  final dio = Dio();
  Locator.registerLazySingleton(() => dio);
  Locator.registerLazySingleton(() => AuthService());
  Locator.registerLazySingleton(() => ImagePicker());
}
