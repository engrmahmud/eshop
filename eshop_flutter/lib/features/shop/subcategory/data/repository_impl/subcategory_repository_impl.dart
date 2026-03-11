import 'package:dartz/dartz.dart';
import 'package:eshop_client/eshop_client.dart';
import 'package:eshop_flutter/core/error/failure.dart';
import 'package:eshop_flutter/features/shop/subcategory/data/datasources/subcategory_datasource.dart';
import 'package:eshop_flutter/features/shop/subcategory/domain/entites/subcategory_entity.dart';
import 'package:eshop_flutter/features/shop/subcategory/domain/repository/subcategory_repository.dart';

class SubcategoryRepositoryImpl implements SubcategoryRepository {
  final SubcategoryDatasource datasource;

  SubcategoryRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, SubcategoryEntity>> createSubcategory(
    SubcategoryEntity subcategory,
  ) async {
    try {
      final result = await datasource.createSubcategory(
        Subcategory(
          id: subcategory.id == 0 ? null : subcategory.id,
          name: subcategory.name,
          description: subcategory.description,
          imageUrl: subcategory.imageUrl,
          categoryId: subcategory.categoryId,
        ),
      );
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSubcategory(int id) async {
    try {
      final result = await datasource.deleteSubcategory(id);
      return result.fold(
        (failure) => Left(failure),
        (success) => const Right(unit),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubcategoryEntity>>> getAllSubcategories(
    int categoryId,
  ) async {
    try {
      final result = await datasource.getAllSubcategories(categoryId);
      return result.map(
        (subcategories) => subcategories.map(_mapToEntity).toList(),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubcategoryEntity>> getSubcategoryById(int id) async {
    try {
      final result = await datasource.getSubcategoryById(id);
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubcategoryEntity>> updateSubcategory(
    SubcategoryEntity subcategory,
  ) async {
    try {
      final result = await datasource.updateSubcategory(
        Subcategory(
          id: subcategory.id,
          name: subcategory.name,
          description: subcategory.description,
          imageUrl: subcategory.imageUrl,
          categoryId: subcategory.categoryId,
        ),
      );
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  SubcategoryEntity _mapToEntity(Subcategory subcategory) {
    return SubcategoryEntity(
      id: subcategory.id!,
      name: subcategory.name,
      description: subcategory.description,
      imageUrl: subcategory.imageUrl,
      categoryId: subcategory.categoryId,
    );
  }
}
