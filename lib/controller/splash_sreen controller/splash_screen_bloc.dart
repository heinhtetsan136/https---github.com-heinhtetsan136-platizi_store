import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/controller/splash_sreen%20controller/splash_screen_state.dart';
import 'package:platzi_app/controller/splash_sreen%20controller/splash_scrren_event.dart';
import 'package:platzi_app/core/entity/token.dart';
import 'package:platzi_app/core/error/error.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/model/result.dart';
import 'package:platzi_app/core/service/auth_service.dart';
import 'package:platzi_app/core/service/share_pref.dart';
import 'package:platzi_app/core/utils/toekn_key.dart';
import 'package:platzi_app/locator.dart';

class SplashScreenBloc extends Bloc<SplashScrrenBaseEvent, SplashScreenState> {
  final SharePref _sharedPreferences = Locator.get<SharePref>();
  final AuthService _authService = Locator.get<AuthService>();
  SplashScreenBloc(super.initialState) {
    on<SplashScreenEvent>((_, emit) async {
      final accessToken =
          await _sharedPreferences.getToken(ToeknKey.accesstoken);

      final refreshToken =
          await _sharedPreferences.getToken(ToeknKey.refreshtoken);
      // await _sharedPreferences
      //     .saveToken(Token(acesstoken: "", refreshtoken: " refreshToken.data"));/// changing login
      emit(SplashScreenLoadingState());
      if (accessToken.hasError || refreshToken.hasError) {
        emit(SplashScreenErrorState("UnAuthorized"));
        return;
      }
      final result = await hasUser(accessToken.data, refreshToken.data);
      if (result.hasError) {
        final data = await _authService
            .getAccessTokenwithRefreshToken(refreshToken.data);

        if (data.hasError) {
          logger.e("new token ${data.error!.messsage}");
          emit(SplashScreenErrorState(data.error!.messsage));
          return;
        }
        final Token newToken = Token.fromJson(data.data);
        logger.i("new Token $newToken");
        _sharedPreferences.saveToken(newToken);
        final newresult = await hasUser(accessToken.data, refreshToken.data);
        if (newresult.hasError) {
          logger.e("new token ${newresult.error!.messsage}");
          emit(SplashScreenErrorState(newresult.error!.messsage));
        }
        emit(SplashScreengotoHome());
      }
      logger.i("splash bloc ${result.data.toString()}");
      emit(SplashScreengotoHome());
    });
    add(const SplashScreenEvent());
  }
  Future<Result> hasUser(String accessToken, String refreshToken) async {
    logger.i("accessToken $accessToken,$refreshToken");
    final result = await _authService.getUserSection(accessToken, refreshToken);
    if (result.hasError) {
      return Result(error: GeneralError(result.error!.messsage));
    }
    return Result(data: result.data);
  }
}
