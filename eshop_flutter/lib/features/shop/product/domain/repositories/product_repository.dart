import 'package:dartz/dartz.dart';
import 'package:eshop_flutter/core/error/failure.dart';
import 'package:eshop_flutter/features/shop/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>> getProductById(int id);
  Future<Either<Failure, ProductEntity>> createProduct(ProductEntity product);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
  Future<Either<Failure, Unit>> deleteProduct(int id);
}
