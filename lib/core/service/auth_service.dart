import 'dart:async';

import 'package:dio/dio.dart';
import 'package:platzi_app/core/api/api.dart';
import 'package:platzi_app/core/entity/usermodel.dart';
import 'package:platzi_app/core/error/error.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/model/result.dart';
import 'package:platzi_app/locator.dart';

class AuthService {
  final dio = Locator.get<Dio>();
  // final StreamController _authstateController = StreamController.broadcast();
  // Stream get authStateChange => _authstateController.stream;
  AuthService();
  Future<Result> login(String email, String password) async {
    const String path = "${Api.URLV1}${Api.LoginAPI}";
    logger.i(path);
    try {
      final result = await dio.post(path, data: {
        "email": email,
        "password": password,
      });

      logger.i(result.data);

      return Result(data: result.data);
    } catch (e) {
      logger.e(e);

      return Result(error: GeneralError(e.toString()));
    }
  }

  Future<Result> signUp(UserParams userparams) async {
    try {
      final payload = userparams.toCreate();

      print(payload.toString());
      final result = await dio.post(Api.GetAllUsers, data: payload);
      logger.i(result.data);

      return Result(data: result.data);
    } catch (e) {
      logger.i(e);
      return Result(error: GeneralError(e.toString()));
    }
  }
}
