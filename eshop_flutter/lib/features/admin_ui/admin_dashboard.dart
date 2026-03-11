import 'package:eshop_flutter/core/dependencies/di_injection.dart';
import 'package:eshop_flutter/core/layout/responsive.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_bloc.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eshop_flutter/features/shop/product/presentation/widgets/product_crud_panel.dart';
import 'package:go_router/go_router.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(const ProductFetch()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.isMobile ? 'Admin' : 'Admin Dashboard'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => context.go('/'),
              icon: Icon(Icons.store_rounded),
            ),
          ],
        ),
        body: MaxWidth(
          maxwidth: 1200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.isDesktop) _buildSidebar(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ProductCrudPanel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSidebar(BuildContext context) {
  return Container(
    width: 200,
    color: Colors.blue.shade50,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue.shade100),
          child: Center(
            child: Text(
              'Admin Menu',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text('Shop'),
          onTap: () {
            context.go('/');
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Products'),
          onTap: () => context.go('/'),
        ),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('Categories'),
          onTap: () => context.go('/admin/categories'),
        ),
        ListTile(
          leading: const Icon(Icons.category_rounded),
          title: const Text('Subcategories'),
          onTap: () => context.go('/admin/subcategories'),
        ),
      ],
    ),
  );
}
