import 'package:dartz/dartz.dart';
import 'package:eshop_flutter/core/error/failure.dart';
import 'package:eshop_flutter/features/shop/subcategory/domain/entites/subcategory_entity.dart';

abstract class SubcategoryRepository {
  Future<Either<Failure, List<SubcategoryEntity>>> getAllSubcategories(
    int categoryId,
  );
  Future<Either<Failure, SubcategoryEntity>> getSubcategoryById(int id);
  Future<Either<Failure, SubcategoryEntity>> createSubcategory(
    SubcategoryEntity subcategory,
  );
  Future<Either<Failure, SubcategoryEntity>> updateSubcategory(
    SubcategoryEntity subcategory,
  );
  Future<Either<Failure, Unit>> deleteSubcategory(int id);
}
