import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/controller/splash_sreen%20controller/splash_screen_cubit.dart';
import 'package:platzi_app/controller/splash_sreen%20controller/splash_screen_state.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/route/route_name.dart';
import 'package:starlight_utils/starlight_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SplashScreenCubit>();
    return BlocConsumer<SplashScreenCubit, SplashScreenState>(
      listener: (_, state) {
        logger.i("state is $state");
        print(state);
        if (state is SplashScreenLoginState) {
          StarlightUtils.pushReplacementNamed(RouteName.login);
          StarlightUtils.snackbar(SnackBar(content: Text(state.message)));
        }
        if (state is SplashScreengotoHome) {
          StarlightUtils.pushReplacementNamed(RouteName.home);
        }
      },
      builder: (_, state) {
        return Scaffold(
          body: SizedBox(
            width: context.width,
            height: context.height,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(
                  size: 120,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please Wait"),
                    SizedBox(
                      width: 10,
                    ),
                    CupertinoActivityIndicator(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
