import 'package:flutter/material.dart';
import 'package:platzi_app/core/utils/toekn_key.dart';
import 'package:platzi_app/locator.dart';
import 'package:platzi_app/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starlight_utils/starlight_utils.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          OutlinedButton(
              onPressed: () async {
                await Locator.get<SharedPreferences>()
                    .setString(TokenKey.accesstoken, "");
                await Locator.get<SharedPreferences>()
                    .setString(TokenKey.refreshtoken, "");
                StarlightUtils.pushReplacementNamed(RouteName.spalsh);
              },
              child: const Text("Logout")),
          OutlinedButton(onPressed: () async {}, child: const Text("Refresh")),
        ],
      ),
    );
  }
}
