import 'package:dartz/dartz.dart';
import 'package:eshop_flutter/core/error/failure.dart';
import 'package:eshop_flutter/features/shop/category/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, CategoryEntity>> getCategoryById(int id);
  Future<Either<Failure, CategoryEntity>> createCategory(
    CategoryEntity category,
  );
  Future<Either<Failure, CategoryEntity>> updateCategory(
    CategoryEntity category,
  );
  Future<Either<Failure, Unit>> deleteCategory(int id);
}
