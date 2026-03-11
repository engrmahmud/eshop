import 'package:equatable/equatable.dart';
import 'package:eshop_flutter/features/shop/subcategory/domain/entites/subcategory_entity.dart';

abstract class SubcategoryEvent extends Equatable {
  const SubcategoryEvent();

  @override
  List<Object> get props => [];
}

class SubcategoryFetch extends SubcategoryEvent {
  final int categoryId;

  const SubcategoryFetch(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class CreateSubcategory extends SubcategoryEvent {
  final SubcategoryEntity subcategory;

  const CreateSubcategory(this.subcategory);

  @override
  List<Object> get props => [subcategory];
}

class UpdateSubcategory extends SubcategoryEvent {
  final SubcategoryEntity subcategory;

  const UpdateSubcategory(this.subcategory);

  @override
  List<Object> get props => [subcategory];
}

class DeleteSubcategory extends SubcategoryEvent {
  final int id;

  const DeleteSubcategory(this.id);

  @override
  List<Object> get props => [id];
}
