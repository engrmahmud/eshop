import 'package:eshop_client/eshop_client.dart';
import 'package:eshop_flutter/features/shop/category/data/datasources/category_datasource.dart';
import 'package:eshop_flutter/features/shop/category/data/repository_impl/category_repositry_impl.dart';
import 'package:eshop_flutter/features/shop/category/domain/repository/category_repository.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_bloc.dart';
import 'package:eshop_flutter/features/shop/product/data/datasources/product_datasource.dart';
import 'package:eshop_flutter/features/shop/product/data/repository_impl/product_repository_impl.dart';
import 'package:eshop_flutter/features/shop/product/domain/repositories/product_repository.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_bloc.dart';
import 'package:eshop_flutter/features/shop/subcategory/data/datasources/subcategory_datasource.dart';
import 'package:eshop_flutter/features/shop/subcategory/data/repository_impl/subcategory_repository_impl.dart';
import 'package:eshop_flutter/features/shop/subcategory/domain/repository/subcategory_repository.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/bloc/subcategory_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init(Client client) {
  //SERVERPOD CLIENT
  sl.registerLazySingleton<Client>(() => client);

  //PRODUCT DATA SOURCES
  sl.registerLazySingleton<ProductDatasource>(
    () => ProductDatasource(sl<Client>()),
  );

  //PRODUCT REPOSITORIES
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductDatasource>()),
  );

  //PRODUCT BLOCs
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl()));

  //CATEGORY DATA SOURCES
  sl.registerLazySingleton<CategoryDatasource>(
    () => CategoryDatasource(sl<Client>()),
  );

  //CATEGORY REPOSITORIES
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl<CategoryDatasource>()),
  );

  // CATEGORY BLOCs
  sl.registerFactory<CategoryBloc>(() => CategoryBloc(sl()));

  //SUBCATEGORY DATA SOURCES
  sl.registerLazySingleton<SubcategoryDatasource>(
    () => SubcategoryDatasource(sl<Client>()),
  );

  //SUBCATEGORY REPOSITORIES
  sl.registerLazySingleton<SubcategoryRepository>(
    () => SubcategoryRepositoryImpl(sl<SubcategoryDatasource>()),
  );

  // SUBCATEGORY BLOCs
  sl.registerFactory<SubcategoryBloc>(
    () => SubcategoryBloc(sl()),
  );
}
