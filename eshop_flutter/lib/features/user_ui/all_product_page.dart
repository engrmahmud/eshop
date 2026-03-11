import 'package:eshop_flutter/core/dependencies/di_injection.dart';
import 'package:eshop_flutter/core/layout/responsive.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_bloc.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_event.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_state.dart';
import 'package:eshop_flutter/features/user_ui/utilities/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(const ProductFetch()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          scrolledUnderElevation: 7,
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          title: Text(
            context.isMobile ? 'E-Shop' : 'E-Shop Onine Store',
            style: const TextStyle(
              color: Color.fromARGB(255, 2, 25, 64),
              fontWeight: FontWeight.bold,
            ),
          ),
          //Header Menu
          actions: [
            TextButton(
              onPressed: () {
                context.go('/cart');
              },
              child: Text(
                'Cart',
                style: TextStyle(
                  fontSize: context.isMobile ? 16 : 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Wishlist',
                style: TextStyle(
                  fontSize: context.isMobile ? 16 : 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: context.isMobile ? 16 : 18,
                ),
              ),
            ),
            context.isMobile ? SizedBox(width: 0) : SizedBox(width: 10),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => context.go('/admin'),
              icon: const Icon(Icons.admin_panel_settings_outlined),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),

        //DRAWER MENU
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 20, 105, 175),
                      Color.fromARGB(255, 16, 93, 95),
                      Color.fromARGB(255, 95, 242, 171),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.isMobile ? 'E-Shop' : 'E-Shop Online Store',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'No-1 Ecommerce in BD',
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: context.isMobile ? 12 : 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Cart'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Wishlist'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: MaxWidth(
          maxwidth: 1200,
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                return ProductGrid(products: state.products);
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
