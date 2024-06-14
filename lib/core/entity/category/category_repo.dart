import 'package:dio/dio.dart';
import 'package:platzi_app/core/api/api.dart';
import 'package:platzi_app/core/error/error.dart';
import 'package:platzi_app/core/model/result.dart';
import 'package:platzi_app/locator.dart';

class CategoryRepo {
  final _dio = Locator.get<Dio>();
  Future<Result> get() async {
    try {
      final result = await _dio.get(Api.GetAllCategory);
      return Result(data: result.data);
    } catch (e) {
      return Result(error: GeneralError(e.toString()));
    }
  }
}
