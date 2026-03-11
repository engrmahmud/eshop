import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int priority;
  final String imageUrl;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.priority,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, description, priority, imageUrl];
}
