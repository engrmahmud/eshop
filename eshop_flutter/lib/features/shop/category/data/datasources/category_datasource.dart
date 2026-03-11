import 'package:dartz/dartz.dart';
import 'package:eshop_client/eshop_client.dart';
import 'package:eshop_flutter/core/error/failure.dart';

class CategoryDatasource {
  final Client client;

  CategoryDatasource(this.client);

  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final result = await client.category.getAllCategories();
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Category>> getCategoryById(int id) async {
    try {
      final result = await client.category.getCategoryById(id);
      return Right(result!);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Category>> createCategory(Category category) async {
    try {
      final result = await client.category.createCategory(category);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Category>> updateCategory(Category category) async {
    try {
      await client.category.updateCategory(category);
      return Right(category);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> deleteCategory(int id) async {
    try {
      await client.category.deleteCategory(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure());
    }
  }
}
