import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_app/controller/register/register_event.dart';
import 'package:platzi_app/controller/register/register_state.dart';
import 'package:platzi_app/core/entity/usermodel.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/model/token.dart';
import 'package:platzi_app/core/service/auth_service.dart';
import 'package:platzi_app/core/utils/toekn_key.dart';
import 'package:platzi_app/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterBloc extends Bloc<RegisterBaseEvent, RegisterBaseState> {
  final ImagePicker _imagePicker = Locator.get<ImagePicker>();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FocusNode emaiFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final ValueNotifier<String> role = ValueNotifier<String>("client");
  final ValueNotifier<bool> isShow = ValueNotifier(false);

  String path = "";
  final SharedPreferences _sharedPreferences = Locator.get<SharedPreferences>();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final AuthService _authService = Locator.get<AuthService>();
  RegisterBloc(super.initialState) {
    on<RegisterEvent>((event, emit) async {
      print(state.path);

      print("register event $state");
      if (formkey.currentState?.validate() != true ||
          state is RegisterLoadingState ||
          state is RegisterPickedImageLoadingState) return;
      emit(RegisterLoadingState(state.path));
      if (state.path.isNotEmpty != true) {
        emit(RegisterErrorState("Avator Photo is Required", path));
        return;
      }
      final result = await _authService.signUp(UserParams.toCreate(
          name: name.text,
          email: email.text,
          password: password.text,
          role: role.value,
          avatar: path));

      if (result.hasError) {
        emit(RegisterErrorState(result.error!.messsage, ""));
        return;
      }
      logger.i("register bloc ${result.data}");
      final tokens = Token.fromJson(result.data);
      await _sharedPreferences.setString(
          TokenKey.accesstoken, tokens.acesstoken);
      await _sharedPreferences.setString(
          TokenKey.refreshtoken, tokens.refreshtoken);
      emit(RegisterSuccessState(state.path));
    });
    on<RegisterPickPhotoEvent>((event, emit) async {
      if (state is RegisterPickedImageLoadingState) return;
      emit(RegisterPickedImageLoadingState(path));
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final result = await _authService.uploadPhoto(File(image.path));
      if (result.hasError) {
        emit(RegisterErrorState(result.error!.messsage.toString(), ""));
        return;
      }
      path = result.data["location"];
      logger.i(result.data["location"]);
      emit(RegisterPickedImageState(image.path));
    });
  }
  void changeRole(String value) {
    if (role.value != value) {
      role.value = value;
    }
  }

  void toggle() {
    print(isShow.value);
    isShow.value = !isShow.value;
  }

  @override
  Future<void> close() {
    nameFocusNode.dispose();
    emaiFocusNode.dispose();
    passwordFocusNode.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    role.dispose();
    isShow.dispose();
    // TODO: implement close
    return super.close();
  }
}
