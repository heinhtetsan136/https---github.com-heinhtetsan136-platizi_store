import 'package:flutter/material.dart';
import 'package:platzi_app/core/entity/token.dart';
import 'package:platzi_app/core/service/share_pref.dart';
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
              child: const Text("Logout"))
        ],
      ),
      body: const Center(
        child: Text("This is Home"),
      ),
    );
  }
}
