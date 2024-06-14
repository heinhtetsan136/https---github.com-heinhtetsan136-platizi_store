import 'package:platzi_app/core/interface/model_interface.dart';
import 'package:platzi_app/core/interface/params_model.dart';

class User extends ModelInterface {
  final String name, email, password, role, avatar;
  final DateTime creationAt, updatedAt;

  User._(
      {required this.name,
      required this.email,
      required this.password,
      required this.role,
      required this.avatar,
      required this.creationAt,
      required this.updatedAt,
      required super.id});
  factory User.fromJson(dynamic data) {
    return User._(
        id: data["id"],
        name: data["name"],
        email: data["email"],
        password: data["password"],
        role: data["role"],
        creationAt: DateTime.parse(data["creationAt"]),
        updatedAt: DateTime.parse(data["updatedAt"]),
        avatar: data["avatar"]);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "avatar": avatar,
      "creationAt": creationAt,
      "updatedAt": updatedAt
    };
  }
}

class UserParams extends ModelParams {
  final String name, email, password, role, avatar;

  UserParams._(
      {required this.name,
      required this.email,
      required this.password,
      required this.role,
      required this.avatar});

  factory UserParams.toCreate({
    required String name,
    required String email,
    required String password,
    required String role,
    required String avatar,
  }) {
    return UserParams._(
        name: name,
        email: email,
        password: password,
        role: role,
        avatar: avatar);
  }
  factory UserParams.toUpdate({
    String? name,
    String? email,
    String? password,
    String? role,
    String? avatar,
  }) {
    return UserParams._(
        name: name ?? "",
        email: email ?? "",
        password: password ?? "",
        role: role ?? "",
        avatar: avatar ?? "");
  }

  @override
  Map<String, dynamic> toUpdate() {
    final Map<String, dynamic> payload = {};
    if (name.isNotEmpty == true) payload["name"] = name;
    if (email.isNotEmpty == true) payload["email"] = email;
    if (password.isNotEmpty == true) payload["password"] = password;
    if (role.isNotEmpty == true) payload["role"] = role;
    if (avatar.isNotEmpty == true) payload["avatar"] = avatar;
    return payload;
  }

  @override
  Map<String, dynamic> toCreate() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "avatar": avatar,
    };
  }
}
