import 'package:platzi_app/core/bloc/bloc_state.dart';

///Register Initial
///Loading
///Success State
///Error State

abstract class RegisterBaseState extends BasicState {
  final String path;
  RegisterBaseState(this.path);
}

class RegisterInitialState extends RegisterBaseState {
  RegisterInitialState(super.path);
}

class RegisterLoadingState extends RegisterBaseState {
  RegisterLoadingState(super.path);
}

class RegisterSuccessState extends RegisterBaseState {
  RegisterSuccessState(super.path);
}

class RegisterPickedImageState extends RegisterBaseState {
  RegisterPickedImageState(super.path);
}

class RegisterPickedImageLoadingState extends RegisterBaseState {
  RegisterPickedImageLoadingState(super.path);
}

class RegisterErrorState extends RegisterBaseState {
  final String error;
  RegisterErrorState(this.error, super.path);
}
