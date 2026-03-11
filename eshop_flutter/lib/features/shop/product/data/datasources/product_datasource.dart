import 'package:dartz/dartz.dart';
import 'package:eshop_client/eshop_client.dart';
import 'package:eshop_flutter/core/error/failure.dart';

class ProductDatasource {
  final Client client;

  ProductDatasource(this.client);

  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      final result = await client.product.createProduct(product);
      return Right(result);
    } catch (e) {
      print(e);
      return Left(Failure());
    }
  }

  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await client.product.getAllProducts();
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final result = await client.product.getProductById(id);
      return Right(result!);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final result = await client.product.updateProduct(product);
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    try {
      await client.product.deleteProduct(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure());
    }
  }
}
