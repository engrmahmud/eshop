import 'package:eshop_flutter/core/dependencies/di_injection.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_bloc.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_event.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_bloc.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_event.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/bloc/subcategory_bloc.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/bloc/subcategory_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBloc extends StatelessWidget {
  const MultiBloc({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CategoryBloc>()..add(CategoryFetch()),
        ),
        BlocProvider(
          create: (context) =>
              sl<SubcategoryBloc>()
                ..add(SubcategoryFetch(0)), // or pass categoryId dynamically
        ),
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(ProductFetch()),
        ),
      ],
      child: child,
    );
  }
}
