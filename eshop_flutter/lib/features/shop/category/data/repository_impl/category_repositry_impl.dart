import 'package:dartz/dartz.dart';
import 'package:eshop_client/eshop_client.dart';
import 'package:eshop_flutter/core/error/failure.dart';
import 'package:eshop_flutter/features/shop/category/data/datasources/category_datasource.dart';
import 'package:eshop_flutter/features/shop/category/domain/entities/category_entity.dart';
import 'package:eshop_flutter/features/shop/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource datasource;

  CategoryRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, CategoryEntity>> createCategory(
    CategoryEntity category,
  ) async {
    try {
      final result = await datasource.createCategory(
        Category(
          id: category.id == 0 ? null : category.id,
          name: category.name,
          description: category.description,
          priority: category.priority,
          imageUrl: category.imageUrl,
        ),
      );
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(int id) async {
    try {
      final result = await datasource.deleteCategory(id);
      return result.fold(
        (failure) => Left(failure),
        (success) => const Right(unit),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final result = await datasource.getAllCategories();
      return result.map((categories) => categories.map(_mapToEntity).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(int id) async {
    try {
      final result = await datasource.getCategoryById(id);
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory(
    CategoryEntity category,
  ) async {
    try {
      final result = await datasource.updateCategory(
        Category(
          id: category.id,
          name: category.name,
          description: category.description,
          priority: category.priority,
          imageUrl: category.imageUrl,
        ),
      );
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  CategoryEntity _mapToEntity(Category category) {
    return CategoryEntity(
      id: category.id!,
      name: category.name,
      description: category.description,
      priority: category.priority,
      imageUrl: category.imageUrl,
    );
  }
}
