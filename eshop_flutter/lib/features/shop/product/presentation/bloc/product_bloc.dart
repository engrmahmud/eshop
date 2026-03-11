import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_event.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<ProductFetch>(_onProductFetch);
    on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onProductFetch(
    ProductFetch event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await repository.getAllProducts();
    result.fold(
      (failure) => emit(ProductError('Failed to fetch products')),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onCreateProduct(
    CreateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await repository.createProduct(event.product);
    result.fold(
      (failure) => emit(ProductError('Failed to create product')),
      (product) => add(ProductFetch()),
    );
  }

  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await repository.updateProduct(event.product);
    result.fold(
      (failure) => emit(ProductError('Failed to update product')),
      (product) => add(ProductFetch()),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await repository.deleteProduct(event.id);
    result.fold(
      (failure) => emit(ProductError('Failed to delete product')),
      (success) => add(ProductFetch()),
    );
  }
}
