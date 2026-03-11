import 'package:equatable/equatable.dart';
import 'package:eshop_flutter/features/shop/product/domain/entities/product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductFetch extends ProductEvent {
  const ProductFetch();

  @override
  List<Object> get props => [];
}

class CreateProduct extends ProductEvent {
  final ProductEntity product;

  const CreateProduct(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final ProductEntity product;

  const UpdateProduct(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final int id;

  const DeleteProduct(this.id);

  @override
  List<Object> get props => [id];
}
