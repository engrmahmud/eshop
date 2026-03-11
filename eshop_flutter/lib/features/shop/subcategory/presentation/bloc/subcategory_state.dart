import 'package:equatable/equatable.dart';
import 'package:eshop_flutter/features/shop/subcategory/domain/entites/subcategory_entity.dart';

class SubcategoryState extends Equatable {
  const SubcategoryState();

  @override
  List<Object> get props => [];
}

class SubcategoryInitial extends SubcategoryState {}

class SubcategoryLoading extends SubcategoryState {}

class SubcategoryLoaded extends SubcategoryState {
  final List<SubcategoryEntity> subcategories;

  const SubcategoryLoaded(this.subcategories);

  @override
  List<Object> get props => [subcategories];
}

class SubcategoryError extends SubcategoryState {
  final String message;

  const SubcategoryError(this.message);

  @override
  List<Object> get props => [message];
}
