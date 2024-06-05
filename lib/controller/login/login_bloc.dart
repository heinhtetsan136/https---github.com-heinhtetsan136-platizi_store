import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/controller/login/login_event.dart';
import 'package:platzi_app/controller/login/login_state.dart';
import 'package:platzi_app/core/service/auth_service.dart';
import 'package:platzi_app/locator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginBaseState> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState>? formkey = GlobalKey<FormState>();
  final AuthService _authService = Locator.get<AuthService>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final ValueNotifier<bool> isShow = ValueNotifier(false);
  late final String token;
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
      token = result.data.toString();
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
