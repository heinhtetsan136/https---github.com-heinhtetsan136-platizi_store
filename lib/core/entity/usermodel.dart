import 'package:platzi_app/core/interface/model_interface.dart';
import 'package:platzi_app/core/interface/params_model.dart';

class User extends ModelInterface {
  final String name, email, password, role, avator;
  final DateTime creationAt, updatedAt;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.role,
      required this.avator,
      required this.creationAt,
      required this.updatedAt,
      required super.id});
  factory User.fromJson(dynamic data) {
    return User(
        id: data["id"],
        name: data["name"],
        email: data["email"],
        password: data["password"],
        role: data["role"],
        creationAt: DateTime.parse(data["creationAt"]),
        updatedAt: DateTime.parse(data["updatedAt"]),
        avator: data["avator"]);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "avator": avator,
      "creationAt": creationAt,
      "updatedAt": updatedAt
    };
  }
}

class UserParams extends ModelParams {
  final String name, email, password, role, avator;

  UserParams._(
      {required this.name,
      required this.email,
      required this.password,
      required this.role,
      required this.avator});

  factory UserParams.toCreate({
    required String name,
    required String email,
    required String password,
    required String role,
    required String avator,
  }) {
    return UserParams._(
        name: name,
        email: email,
        password: password,
        role: role,
        avator: avator);
  }
  factory UserParams.toUpdate({
    String? name,
    String? email,
    String? password,
    String? role,
    String? avator,
  }) {
    return UserParams._(
        name: name ?? "",
        email: email ?? "",
        password: password ?? "",
        role: role ?? "",
        avator: avator ?? "");
  }

  @override
  Map<String, dynamic> toUpdate() {
    final Map<String, dynamic> payload = {};
    if (name.isNotEmpty == true) payload["name"] = name;
    if (email.isNotEmpty == true) payload["email"] = email;
    if (password.isNotEmpty == true) payload["password"] = password;
    if (role.isNotEmpty == true) payload["role"] = role;
    if (avator.isNotEmpty == true) payload["avator"] = avator;
    return payload;
  }

  @override
  Map<String, dynamic> toCreate() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "avatar": avator,
    };
  }
}
