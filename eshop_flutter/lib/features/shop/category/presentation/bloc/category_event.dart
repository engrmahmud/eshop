import 'package:equatable/equatable.dart';
import 'package:eshop_flutter/features/shop/category/domain/entities/category_entity.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryFetch extends CategoryEvent {
  const CategoryFetch();

  @override
  List<Object> get props => [];
}

class CreateCategory extends CategoryEvent {
  final CategoryEntity category;

  const CreateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateCategory extends CategoryEvent {
  final CategoryEntity category;

  const UpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class DeleteCategory extends CategoryEvent {
  final int id;

  const DeleteCategory(this.id);

  @override
  List<Object> get props => [id];
}

//Search Categories
class SearchCategory extends CategoryEvent {
  final String query;

  const SearchCategory(this.query);

  @override
  List<Object> get props => [query];
}

//Get Category By Id
class GetCategoryById extends CategoryEvent {
  final int id;

  const GetCategoryById(this.id);

  @override
  List<Object> get props => [id];
}
