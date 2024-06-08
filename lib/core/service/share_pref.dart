import 'package:platzi_app/core/entity/token.dart';
import 'package:platzi_app/core/error/error.dart';
import 'package:platzi_app/core/model/result.dart';
import 'package:platzi_app/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  SharePref();
  final SharedPreferences sharedPreferences = Locator.get<SharedPreferences>();
  Future<Result> saveToken(Token user) async {
    try {
      final accessToken =
          await sharedPreferences.setString("access_token", user.acesstoken);
      final refreshToken =
          await sharedPreferences.setString("refresh_token", user.acesstoken);
      return Result(data: accessToken);
    } catch (e) {
      return Result(error: GeneralError("error while saving tokens"));
    }
  }

  Future<Result> getToken(String key) async {
    try {
      final token = sharedPreferences.getString(key);

      return Result(data: token);
    } catch (e) {
      return Result(error: GeneralError("error while saving tokens"));
    }
  }
}
