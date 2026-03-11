import 'package:eshop_flutter/core/bloc/multi_bloc.dart';
import 'package:eshop_flutter/features/shop/category/presentation/widgets/category_crud.dart';
import 'package:eshop_flutter/features/admin_ui/admin_dashboard.dart';
import 'package:eshop_flutter/features/shop/product/domain/entities/product_entity.dart';
import 'package:eshop_flutter/features/user_ui/cart_page.dart';
import 'package:eshop_flutter/features/user_ui/home_page.dart';
import 'package:eshop_flutter/features/user_ui/product_details_page.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/widgets/subcategory_crud.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),

    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboard(),
    ),

    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
    GoRoute(
      path: '/product/id',
      builder: (context, state) =>
          ProductDetailsPage(product: state.extra as ProductEntity),
    ),

    GoRoute(
      path: '/admin/categories',
      builder: (context, state) => MultiBloc(
        child: Scaffold(
          appBar: AppBar(title: const Text('Categories')),
          body: const CategoryCrudPanel(),
        ),
      ),
    ),
    GoRoute(
      path: '/admin/subcategories',
      builder: (context, state) => MultiBloc(
        child: Scaffold(
          appBar: AppBar(title: const Text('Subcategories')),
          body: const SubcategoryCrudPanel(),
        ),
      ),
    ),
  ],
);
