import 'package:equatable/equatable.dart';

class SubcategoryEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int categoryId;

  const SubcategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    categoryId,
  ];
}
