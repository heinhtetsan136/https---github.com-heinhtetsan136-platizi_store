import 'package:flutter/material.dart';
import 'package:platzi_app/core/entity/token.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/service/share_pref.dart';
import 'package:platzi_app/core/utils/toekn_key.dart';
import 'package:platzi_app/locator.dart';
import 'package:platzi_app/route/route_name.dart';
import 'package:starlight_utils/starlight_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SharePref sharedPreferences = Locator.get<SharePref>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          OutlinedButton(
              onPressed: () async {
                await sharedPreferences
                    .saveToken(Token(acesstoken: "", refreshtoken: ""));
                StarlightUtils.pushReplacementNamed(RouteName.spalsh);
              },
              child: const Text("Logout")),
          OutlinedButton(
              onPressed: () async {
                final refreshToken =
                    await sharedPreferences.getToken(ToeknKey.refreshtoken);
                logger.i("refresh home ${refreshToken.data}");
                final result = await sharedPreferences.saveToken(
                    Token(acesstoken: "", refreshtoken: refreshToken.data));
                logger.i("reSave");
                Future.delayed(const Duration(seconds: 3));
                StarlightUtils.pushReplacementNamed(RouteName.spalsh);
              },
              child: const Text("Refresh")),
        ],
      ),
      body: const Center(
        child: Text("This is Home"),
      ),
    );
  }
}
