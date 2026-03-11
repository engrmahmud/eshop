import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;
  final int quantity;
  final bool isAvailable;
  final int categoryId;
  final int subcategoryId;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.quantity,
    required this.isAvailable,
    required this.categoryId,
    required this.subcategoryId,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    discount,
    images,
    sizes,
    colors,
    quantity,
    isAvailable,
    categoryId,
    subcategoryId,
  ];
}
