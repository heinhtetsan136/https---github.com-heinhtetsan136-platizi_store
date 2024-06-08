import 'package:platzi_app/core/bloc/bloc_state.dart';

abstract class SplashScreenState extends BasicState {
  SplashScreenState();
}

class SplashScreengotoHome extends SplashScreenState {
  SplashScreengotoHome();
}

class SplashScreengotoLogin extends SplashScreenState {
  SplashScreengotoLogin();
}

class SplashScreenInitialState extends SplashScreenState {
  SplashScreenInitialState();
}

class SplashScreenLoadingState extends SplashScreenState {
  SplashScreenLoadingState();
}

class SplashScreenErrorState extends SplashScreenState {
  final String message;
  SplashScreenErrorState(this.message);
}
