import 'package:dartz/dartz.dart';
import 'package:eshop_client/eshop_client.dart';
import 'package:eshop_flutter/core/error/failure.dart';
import 'package:eshop_flutter/features/shop/product/data/datasources/product_datasource.dart';
import 'package:eshop_flutter/features/shop/product/domain/entities/product_entity.dart';
import 'package:eshop_flutter/features/shop/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
    ProductEntity product,
  ) async {
    try {
      final result = await datasource.createProduct(
        Product(
          id: product.id == 0 ? null : product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          discount: product.discount,
          images: product.images,
          sizes: product.sizes,
          colors: product.colors,
          quantity: product.quantity,
          isAvailable: product.isAvailable,
          subcategoryId: product.subcategoryId,
          categoryId: product.categoryId,
        ),
      );
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    try {
      final result = await datasource.deleteProduct(id);
      return result.fold(
        (failure) => Left(failure),
        (success) => const Right(unit),
      );
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final result = await datasource.getProductById(id);
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final result = await datasource.getAllProducts();
      return result.map((products) => products.map(_mapToEntity).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    ProductEntity product,
  ) async {
    try {
      final result = await datasource.updateProduct(
        Product(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          discount: product.discount,
          images: product.images,
          sizes: product.sizes,
          colors: product.colors,
          quantity: product.quantity,
          isAvailable: product.isAvailable,
          categoryId: product.categoryId,
          subcategoryId: product.subcategoryId,
        ),
      );
      return result.map(_mapToEntity);
    } catch (e) {
      return Left(Failure());
    }
  }

  ProductEntity _mapToEntity(Product product) {
    return ProductEntity(
      id: product.id!,
      name: product.name,
      description: product.description,
      price: product.price,
      discount: product.discount,
      images: product.images ?? [],
      sizes: product.sizes ?? [],
      colors: product.colors ?? [],
      quantity: product.quantity,
      isAvailable: product.isAvailable,
      categoryId: product.categoryId,
      subcategoryId: product.subcategoryId!,
    );
  }
}
