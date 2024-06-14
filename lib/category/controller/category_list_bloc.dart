import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/category/category/category_repo.dart';
import 'package:platzi_app/category/controller/category_list_event.dart';
import 'package:platzi_app/category/controller/category_list_state.dart';
import 'package:platzi_app/core/logger/logger.dart';

class CategoryListBloc extends Bloc<CategoryListBaseEvent, CategoryBaseState> {
  final CategoryRepo categoryRepo;
  CategoryListBloc(super.initialState, this.categoryRepo) {
    on<CategoryRefreshEvent>((_, emit) async {
      emit(CategoryLoadingState(state.category));
      final categories = state.category.toList();
      final result = await categoryRepo.getCategory();

      if (result.hasError) {
        logger.e("Category error ${result.error} ");
        emit(CategoryErrorState(categories, result.error!.messsage));
        return;
      }
      logger.i("bloc of cate${result.data}");
      final category = emit(CategorySuccessState(result.data));
    });
    add(const CategoryRefreshEvent());
  }
}
