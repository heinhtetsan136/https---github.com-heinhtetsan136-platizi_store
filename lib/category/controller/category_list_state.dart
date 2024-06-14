import 'package:platzi_app/core/bloc/bloc_state.dart';

abstract class CategoryListState extends BasicState {
  CategoryListState();
}

class CategoryListInitialState extends CategoryListState {
  CategoryListInitialState();
}

class CategoryListLoadingState extends CategoryListState {
  CategoryListLoadingState();
}

class CategoryListSoftLoadingState extends CategoryListState {
  CategoryListSoftLoadingState();
}

class CategoryListSucessState extends CategoryListState {
  CategoryListSucessState();
}

class CategoryListErrorState extends CategoryListState {
  CategoryListErrorState();
}
