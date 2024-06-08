import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/controller/register/register_bloc.dart';
import 'package:platzi_app/controller/register/register_event.dart';
import 'package:platzi_app/controller/register/register_state.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/route/route_name.dart';
import 'package:starlight_utils/starlight_utils.dart';

final List<String> role = ["client", "admin"];

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = context.read<RegisterBloc>();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    StarlightUtils.pushReplacementNamed(RouteName.login);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ],
          ),
        ),
        const PhotoPicker(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: registerBloc.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const Text(
                  "Enter your Personal information",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 17.0),
                          child: TextFormField(
                            focusNode: registerBloc.nameFocusNode,

                            // onEditingComplete: () {
                            //   Injection<AuthService>()
                            //       .verifyOtp(loginBloc.passwordController.text);
                            // },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isNotEmpty != true) {
                                return "Enter Your Name";
                              }
                              return null;
                            },
                            controller: registerBloc.name,

                            decoration: const InputDecoration(
                              hintText: "Enter your name",
                            ),
                          ),
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        TextFormField(
                          onEditingComplete: () {
                            registerBloc.passwordFocusNode.requestFocus();
                          },
                          focusNode: registerBloc.emaiFocusNode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value?.isNotEmpty == true
                                ? value!.isEmail
                                    ? null
                                    : "invalid_email"
                                : "Email is required";
                          },
                          controller: registerBloc.email,
                          decoration: const InputDecoration(
                            hintText: "Enter your email",
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      ValueListenableBuilder(
                        valueListenable: registerBloc.isShow,
                        builder: (_, value, child) {
                          return TextFormField(
                            focusNode: registerBloc.passwordFocusNode,

                            // onEditingComplete: () {
                            //   Injection<AuthService>()
                            //       .verifyOtp(loginBloc.passwordController.text);
                            // },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isNotEmpty != true) {
                                return "password_is_required";
                              }
                              return null;
                            },
                            controller: registerBloc.password,
                            obscureText: !value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: registerBloc.toggle,
                                  icon: Icon(
                                    value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey.shade500,
                                  )),
                              labelText: "Enter your password",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //         onPressed: () {},
                //         child: const Text(
                //           "Forgot Password?",
                //           style: TextStyle(fontSize: 12),
                //         )),
                //   ],
                // ),
                ListTile(
                  title: const Text("Select Your Role"),
                  trailing: ValueListenableBuilder(
                      valueListenable: registerBloc.role,
                      builder: (_, value, child) {
                        return DropdownButton(
                            value: value,
                            items: role
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              registerBloc.changeRole(value!);
                            });
                      }),
                ),
                SizedBox(
                  width: context.width,
                  child: ElevatedButton(
                      onPressed: () async {
                        registerBloc.add(const RegisterEvent());
                      },
                      child: BlocConsumer<RegisterBloc, RegisterBaseState>(
                          builder: (_, state) {
                        if (state is RegisterPickedImageLoadingState) {
                          return const Text(
                              "Please wait while uploading photo");
                        }
                        if (state is RegisterLoadingState) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        return const Text("Register");
                      }, listener: (_, state) {
                        if (state is RegisterErrorState) {
                          StarlightUtils.dialog(AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    StarlightUtils.pop();
                                  },
                                  child: const Text("OK"))
                            ],
                            title: const Text("Failed to Create Acount"),
                            content: Text(state.error),
                          ));
                        }
                        if (state is RegisterSuccessState) {
                          StarlightUtils.pushReplacementNamed(RouteName.home,
                              arguments: registerBloc.accessToken);
                        }
                      })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          StarlightUtils.pushReplacementNamed(RouteName.login);
                        },
                        child: const Text("Login"))
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    ));
  }
}

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = context.read<RegisterBloc>();
    return GestureDetector(
      onTap: () {
        registerBloc.add(const RegisterPickPhotoEvent());
      },
      child: BlocBuilder<RegisterBloc, RegisterBaseState>(
        builder: (_, state) {
          logger.w(
              "ShopCoverPhotoPicker builder get an event ${registerBloc.path}");

          final path = registerBloc.path;
          if (path.isNotEmpty) {
            return CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File(state.path)),
            );
          }
          return Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.theme.shadowColor,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.image,
            ),
          );
        },
      ),
    );
  }
}
