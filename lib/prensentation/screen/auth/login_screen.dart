import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:platzi_app/controller/login/login_bloc.dart';
import 'package:platzi_app/controller/login/login_event.dart';
import 'package:platzi_app/controller/login/login_state.dart';
import 'package:platzi_app/route/route_name.dart';
import 'package:starlight_utils/starlight_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginBloc.formkey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 60, right: 10.0, left: 10.0),
                child: SizedBox(
                  width: context.width * 0.75,
                  height: context.height * 0.3,
                  child: Lottie.asset("assets/images/lottie.json",
                      fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      "Login to continue using the app",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            TextFormField(
                              onEditingComplete: () {
                                loginBloc.passwordFocusNode.requestFocus();
                              },
                              focusNode: loginBloc.emailFocusNode,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return value?.isNotEmpty == true
                                    ? value!.isEmail
                                        ? null
                                        : "invalid_email"
                                    : "Email is required";
                              },
                              controller: loginBloc.email,
                              decoration: const InputDecoration(
                                hintText: "Enter your email",
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          ValueListenableBuilder(
                              valueListenable: loginBloc.isShow,
                              builder: (_, value, child) {
                                return TextFormField(
                                  onEditingComplete: () {
                                    loginBloc.passwordFocusNode.unfocus();
                                  },
                                  focusNode: loginBloc.passwordFocusNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  // validator: (value) {
                                  //   // if (value == null) {
                                  //   //   return "password_is_required";
                                  //   // }
                                  //   // return value.isStrongPassword(
                                  //   //   minLength: 6,
                                  //   //   checkUpperCase: false,
                                  //   //   checkSpecailChar: false,
                                  //   // );
                                  // },
                                  controller: loginBloc.password,
                                  obscureText: !value,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          loginBloc.toggle();
                                        },
                                        icon: value
                                            ? const Icon(
                                                Icons.visibility,
                                              )
                                            : const Icon(Icons.visibility_off)),
                                    hintText: "Enter your password",
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: context.width,
                        child: ElevatedButton(
                            onPressed: () async {
                              loginBloc.add(const OnLoginEvent());
                            },
                            child: BlocConsumer<LoginBloc, LoginBaseState>(
                                builder: (_, state) {
                              if (state is LoginLoadingState) {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              }
                              return const Text("Login");
                            }, listener: (_, state) {
                              if (state is LoginFailState) {
                                StarlightUtils.dialog(AlertDialog(
                                  title: const Text("Failed to Login "),
                                  content: Text(state.error),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          StarlightUtils.pop();
                                        },
                                        child: const Text("OK"))
                                  ],
                                ));
                              }
                              if (state is LoginSuccessState) {
                                StarlightUtils.pushReplacementNamed(
                                  RouteName.home,
                                );
                              }
                            })),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              StarlightUtils.pushNamed(RouteName.signin);
                            },
                            child: const Text("Register here"))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
