import 'package:dartz/dartz.dart';
import 'package:eshop_client/eshop_client.dart';
import 'package:eshop_flutter/core/error/failure.dart';

class SubcategoryDatasource {
  final Client client;

  SubcategoryDatasource(this.client);

  Future<Either<Failure, List<Subcategory>>> getAllSubcategories(
    int categoryId,
  ) async {
    try {
      final result = await client.subcategory.getAllSubcategories();
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Subcategory>> getSubcategoryById(int id) async {
    try {
      final result = await client.subcategory.getSubcategoryById(id);
      return Right(result!);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Subcategory>> createSubcategory(
    Subcategory subcategory,
  ) async {
    try {
      final result = await client.subcategory.createSubcategory(subcategory);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Subcategory>> updateSubcategory(
    Subcategory subcategory,
  ) async {
    try {
      await client.subcategory.updateSubcategory(subcategory);
      return Right(subcategory);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> deleteSubcategory(int id) async {
    try {
      await client.subcategory.deleteSubcategory(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure());
    }
  }
}
