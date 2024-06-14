import 'package:equatable/equatable.dart';
import 'package:platzi_app/category/category/category_entity.dart';

abstract class CategoryBaseState extends Equatable {
  final List<Category> category;

  const CategoryBaseState(this.category);

  @override
  List<Object?> get props => category;
}

class CategoryInitialState extends CategoryBaseState {
  const CategoryInitialState() : super(const []);
}

class CategoryLoadingState extends CategoryBaseState {
  const CategoryLoadingState(super.category);
}

class CategorySoftLoadingState extends CategoryBaseState {
  const CategorySoftLoadingState(super.category);
}

class CategorySuccessState extends CategoryBaseState {
  final DateTime _createdAt = DateTime.now();

  CategorySuccessState(super.category);

  @override
  // TODO: implement props
  List<Object?> get props => [super.props, _createdAt];
}

class CategoryErrorState extends CategoryBaseState {
  final String? message;

  const CategoryErrorState(super.Categorys, this.message);

  @override
  List<Object?> get props => [...super.props, message];
}
