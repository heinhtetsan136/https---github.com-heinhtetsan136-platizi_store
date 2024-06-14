import 'dart:convert';

abstract class ModelInterface {
  final int id;
  final DateTime creationAt;
  final DateTime updatedAt;
  const ModelInterface(
      {required this.id, required this.creationAt, required this.updatedAt});
  Map<String, dynamic> toJson();

  @override
  operator ==(covariant ModelInterface other) {
    return other.id == id && other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => id & runtimeType.hashCode;

  @override
  String toString() {
    return json.encode(toJson());
  }
}
