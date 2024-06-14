import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/controller/splash_sreen%20controller/splash_screen_state.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/model/token.dart';
import 'package:platzi_app/core/service/auth_service.dart';
import 'package:platzi_app/core/utils/toekn_key.dart';
import 'package:platzi_app/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final AuthService _authService = Locator.get<AuthService>();
  Map<String, String?> tokens = {};
  SplashScreenCubit() : super(SplashScreenInitialState()) {
    verified();
  }
  final SharedPreferences sharedPreferences = Locator.get<SharedPreferences>();
  void verified() async {
    emit(SplashScreenLoadingState());
    tokens[TokenKey.accesstoken] =
        sharedPreferences.getString(TokenKey.accesstoken);
    tokens[TokenKey.refreshtoken] =
        sharedPreferences.getString(TokenKey.refreshtoken);
    logger.e(tokens);
    if (!(tokens[TokenKey.accesstoken]?.isNotEmpty == true) ||
        !(tokens[TokenKey.refreshtoken]?.isNotEmpty == true)) {
      logger.e("No token");
      emit(SplashScreenLoginState("PleaseLoginFires"));
      return;
    }
    logger.e("Have token");
    final result = await _authService
        .getUserProfielwithAccessToken(tokens[TokenKey.accesstoken]!);
    logger.i("${result.hasError}");
    if (result.hasError) {
      final renewtoken = await _authService
          .getAccessTokenwithRefreshToken(tokens[TokenKey.refreshtoken]!);
      if (renewtoken.hasError) {
        emit(SplashScreenLoginState("PleaseLoginFirst"));
        return;
      }
      final Token token = Token.fromJson(renewtoken.data);

      await sharedPreferences.setString(TokenKey.accesstoken, token.acesstoken);
      await sharedPreferences.setString(
          TokenKey.refreshtoken, token.refreshtoken);

      // emit(state)
    }
    //     // await _sharedPreferences
    emit(SplashScreengotoHome());
  }
}
