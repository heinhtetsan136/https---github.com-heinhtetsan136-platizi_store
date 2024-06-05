import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_app/controller/register/register_event.dart';
import 'package:platzi_app/controller/register/register_state.dart';
import 'package:platzi_app/core/entity/usermodel.dart';
import 'package:platzi_app/core/service/auth_service.dart';
import 'package:platzi_app/locator.dart';

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
  Map<String, dynamic> accessToken = {};
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final AuthService _authService = Locator.get<AuthService>();
  RegisterBloc(super.initialState) {
    on<RegisterEvent>((_, event) async {
      print("register event $state");
      if (formkey.currentState?.validate() != true ||
          state is RegisterLoadingState) return;

      emit(RegisterLoadingState(state.path));
      final result = await _authService.signUp(UserParams.toCreate(
          name: name.text,
          email: email.text,
          password: password.text,
          role: role.value,
          avator: path));

      if (result.hasError) {
        emit(RegisterErrorState(result.error!.messsage, ""));
        return;
      }
      accessToken = result.data;
      emit(RegisterSuccessState(state.path));
    });
    on<RegisterPickPhotoEvent>((_, event) async {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      path = image.path;
      emit(RegisterPickedImageState(path));
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
}
