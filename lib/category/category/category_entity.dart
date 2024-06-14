import 'package:platzi_app/core/interface/model_interface.dart';
import 'package:platzi_app/core/interface/params_model.dart';
import 'package:platzi_app/core/logger/logger.dart';

class Category extends ModelInterface {
  final String name;
  final Uri? image;

  Category._(
      {required super.id,
      required this.name,
      required this.image,
      required super.creationAt,
      required super.updatedAt});
  factory Category.fromJson(dynamic data) {
    logger.i("from model ${data.toString()}");
    return Category._(
        id: int.parse(data["id"]),
        name: data["name"],
        creationAt: DateTime.parse(data["creationAt"]),
        updatedAt: DateTime.parse(data["updatedAt"]),
        image: Uri.tryParse(data["image"] ?? ""));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }
}

class CategoryParams extends ModelParams {
  final String name, image;

  CategoryParams._({required this.name, required this.image});
  factory CategoryParams.toCreate({
    required String name,
    required String image,
  }) {
    return CategoryParams._(name: name, image: image);
  }
  factory CategoryParams.toUpdate({
    String? name,
    String? image,
  }) {
    return CategoryParams._(name: name ?? "", image: image ?? "");
  }
  @override
  Map<String, dynamic> toCreate() {
    return {
      "name": name,
      "image": image,
    };
  }

  @override
  Map<String, dynamic> toUpdate() {
    final Map<String, dynamic> payload = {};
    if (name.isNotEmpty == true) payload["name"] = name;
    if (image.isNotEmpty == true) payload["image"] = image;
    return payload;
  }
}
