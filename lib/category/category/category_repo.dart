import 'package:dio/dio.dart';
import 'package:platzi_app/category/category/category_entity.dart';
import 'package:platzi_app/core/api/api.dart';
import 'package:platzi_app/core/error/error.dart';
import 'package:platzi_app/core/logger/logger.dart';
import 'package:platzi_app/core/model/result.dart';
import 'package:platzi_app/locator.dart';

class CategoryRepo {
  final _dio = Locator.get<Dio>();
  Future<Result> getCategory([int? i]) async {
    try {
      final getone = i == null ? "" : "/$i";
      final result = await _dio.get("${Api.GetAllCategory}$getone");
      if (result.data == null) {
        return Result(error: GeneralError("There is No Posts"));
      }

      final body = result.data as List;

      logger.e(body);
      logger.e("repo ${body.map((e) => Category.fromJson(e)).toList()}");
      List<Category> category = body.map(Category.fromJson).toList();
      logger.e("category repo $category");
      // final List<Category> category = body.map(Category.fromJson).toList();
      // logger.i(category);

      // final category = u.map((e) {
      //   logger.e("e.t ${e.toString()}");
      //   return Category.fromJson(e);
      // }).toList();
      // logger.e(category);
      return Result(data: category);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }

  Future<Result> CreateCategory(CategoryParams category) async {
    try {
      final payload = category.toCreate();
      final result = await _dio.post("${Api.GetAllCategory}/", data: payload);
      if (result.data == null) {
        return Result(error: GeneralError("Failed to Create Post"));
      }
      return Result(data: result.data);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }

  Future<Result> UpdateCategory(CategoryParams category, int id) async {
    try {
      final payload = category.toUpdate();
      final result = await _dio.put("${Api.GetAllCategory}/$id", data: payload);
      if (result.data == null) {
        return Result(error: GeneralError("Failed to Update"));
      }
      return Result(data: result.data);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }

  Future<Result> DeleteCategory(int id) async {
    try {
      final result = await _dio.delete("${Api.GetAllCategory}/id");
      if (result.data != true) {
        return Result(error: GeneralError("Failed to Delete"));
      }
      return Result(data: result.data);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }
}
