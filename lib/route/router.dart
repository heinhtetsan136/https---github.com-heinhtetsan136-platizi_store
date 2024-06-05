import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/controller/login/login_bloc.dart';
import 'package:platzi_app/controller/login/login_state.dart';
import 'package:platzi_app/controller/register/register_bloc.dart';
import 'package:platzi_app/controller/register/register_state.dart';
import 'package:platzi_app/prensentation/screen/auth/login_screen.dart';
import 'package:platzi_app/prensentation/screen/auth/register_screen.dart';
import 'package:platzi_app/prensentation/screen/home/home_screen.dart';
import 'package:platzi_app/route/route_name.dart';

Route router(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.signUp:
      return _routebuilder(
          BlocProvider(
              create: (_) => LoginBloc(const LoginInitialState()),
              child: const LoginScreen()),
          settings);
    case RouteName.signin:
      return _routebuilder(
          BlocProvider(
              create: (_) => RegisterBloc(RegisterInitialState("")),
              child: const RegisterScreen()),
          settings);
    case RouteName.home:
      return _routebuilder(const HomeScreen(), settings);
    default:
      return _routebuilder(
          BlocProvider(
              create: (_) => LoginBloc(const LoginInitialState()),
              child: const LoginScreen()),
          settings);
  }
}

Route _routebuilder(Widget screen, RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => screen, settings: settings);
}
