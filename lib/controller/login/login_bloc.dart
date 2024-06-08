import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/controller/login/login_event.dart';
import 'package:platzi_app/controller/login/login_state.dart';
import 'package:platzi_app/core/entity/token.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/service/auth_service.dart';
import 'package:platzi_app/core/service/share_pref.dart';
import 'package:platzi_app/core/utils/toekn_key.dart';
import 'package:platzi_app/locator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginBaseState> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState>? formkey = GlobalKey<FormState>();
  final AuthService _authService = Locator.get<AuthService>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final ValueNotifier<bool> isShow = ValueNotifier(false);
  final SharePref _sharePref = Locator.get<SharePref>();
  LoginBloc(super.initialState) {
    on<OnLoginEvent>((_, emit) async {
      if (formkey?.currentState?.validate() != true ||
          state is LoginLoadingState) return;
      emit(const LoginLoadingState());
      final result = await _authService.login(email.text, password.text);
      if (result.hasError) {
        emit(LoginFailState(result.error!.messsage.toString()));
        return;
      }
      final token = await _sharePref.saveToken(Token.fromJson(result.data));
      if (token.hasError) {
        emit(const LoginFailState("Your account token are not found"));
      }
      logger.i(
          "token are ${(await _sharePref.getToken(ToeknKey.accesstoken)).data}.${await _sharePref.getToken(ToeknKey.refreshtoken)}");
      logger.i("result in login ${result.data}");
      emit(const LoginSuccessState());
    });
  }
  void toggle() {
    print(isShow.value);
    isShow.value = !isShow.value;
  }

  @override
  Future<void> close() {
    email.dispose();
    isShow.dispose();
    password.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    formkey == null;
    // TODO: implement close
    return super.close();
  }
}
