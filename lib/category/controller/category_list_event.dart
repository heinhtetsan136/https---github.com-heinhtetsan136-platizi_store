import 'package:platzi_app/category/category/category_entity.dart';

abstract class CategoryListBaseEvent {
  const CategoryListBaseEvent();
}

class CategoryNextPageEvent extends CategoryListBaseEvent {
  const CategoryNextPageEvent();
}

class CategoryListNewCategoryEvent extends CategoryListBaseEvent {
  final List<Category> newCategory;

  const CategoryListNewCategoryEvent(this.newCategory);
}

class SearchNewCategoryEvent extends CategoryListBaseEvent {
  const SearchNewCategoryEvent();
}

class CategoryRefreshEvent extends CategoryListBaseEvent {
  const CategoryRefreshEvent();
}
