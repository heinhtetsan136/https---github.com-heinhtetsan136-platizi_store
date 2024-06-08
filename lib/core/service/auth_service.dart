import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:platzi_app/core/api/api.dart';
import 'package:platzi_app/core/entity/usermodel.dart';
import 'package:platzi_app/core/error/error.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/model/result.dart';
import 'package:platzi_app/locator.dart';

class AuthService {
  final dio = Locator.get<Dio>();
  final StreamController<String> _photo = StreamController.broadcast();
  Stream<String> get photo => _photo.stream;

  // final StreamController _authstateController = StreamController.broadcast();
  // Stream get authStateChange => _authstateController.stream;
  AuthService();
  Future<Result> getUserSection(String accesstoken, String refreshtoken) async {
    try {
      final result = await getUserwithAccessToken(accesstoken);
      logger.i("getuser ${result.hasError}");

      logger.i("getuser ${result.data}");
      return Result(data: result);
    } catch (e) {
      return Result(error: GeneralError("Check Your Connection"));
    }
  }

  Future<Result> getAccessTokenwithRefreshToken(String refreshToken) async {
    logger.i("getaccessTokenwithrefreshtoken $refreshToken");
    try {
      final result = await dio.post("${Api.URLV1}${Api.RefreshAPI}",
          data: {"refreshToken": refreshToken});
      logger.i("getaccessTokenwithrefreshtoken $result");

      return Result(data: result.data);
    } on DioException catch (e) {
      logger.e("error ${e.response?.statusCode == 401}");
      if (e.response?.statusCode == 401) {
        return Result(error: GeneralError("UnAuthorized Error"));
      }
      return Result(error: GeneralError("Please Login First"));
    } catch (e) {
      return Result(error: GeneralError("Please Login First"));
    }
  }

  Future<Result> getUserwithAccessToken(String accessToken) async {
    try {
      final result = await dio.get("${Api.URLV1}${Api.ProfileAPI}",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));
      logger.i(result.data);
      return Result(data: result);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }

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
    final payload = userparams.toCreate();
    final check = await checkemail(payload["email"]);
    logger.i("check ${check.data}");
    print(payload.toString());
    final result = await dio.post(Api.GetAllUsers, data: payload);
    logger.i("signUp ${result.data}");
    final User user = User.fromJson(result.data);
    logger.i("user ${user.email}");
    final token = await login(user.email, user.password);
    if (token.hasError) {
      return Result(error: GeneralError("Token cannot be had"));
    }
    logger.i(token.data);

    return Result(data: token.data);
    // try {

    // } catch (e) {
    //   logger.e(e);
    //   return Result(error: GeneralError(e.toString()));
    // }
  }

  Future<Result> uploadPhoto(File path) async {
    print("photo $photo ${photo.runtimeType}");
    try {
      final fileBinary = await MultipartFile.fromFile(path.path);
      final result = await dio.post(Api.Profilephoto,
          data: FormData.fromMap({"file": fileBinary}));
      logger.i(result.data);
      return Result(data: result.data);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }

  Future<Result> checkemail(String email) async {
    try {
      final result = await dio.post(Api.CheckEmail, data: {"email": email});
      return Result(data: result.data);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }
}
