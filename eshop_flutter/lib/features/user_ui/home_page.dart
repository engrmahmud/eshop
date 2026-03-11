import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop_flutter/core/dependencies/di_injection.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_state.dart';
import 'package:eshop_flutter/features/user_ui/utilities/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eshop_flutter/core/layout/responsive.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_bloc.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_event.dart';
import 'package:eshop_flutter/features/shop/product/domain/entities/product_entity.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocProvider(
        create: (_) => sl<ProductBloc>()..add(const ProductFetch()),
        child: SingleChildScrollView(
          child: MaxWidth(
            maxwidth: 1200,
            child: Column(
              children: [
                // Carousel Banner
                CarouselSlider(
                  options: CarouselOptions(
                    height: 220.0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                  ),
                  items:
                      [
                        'assets/images/banner/banner1.jpg',
                        'assets/images/banner/banner2.jpg',
                        'assets/images/banner/banner3.jpg',
                        'assets/images/banner/banner4.jpg',
                        'assets/images/banner/banner5.jpg',
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.asset(
                              i,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        );
                      }).toList(),
                ),

                const SizedBox(height: 5),

                // Featured Products
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoaded) {
                      return ProductGrid(
                        products: state.products,
                        title: 'Featured Products',
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // const SizedBox(height: 15),

                // Category Sections
                _CategorySection(title: "Fashion", categoryId: 7),
                _CategorySection(title: "Electronics", categoryId: 7),
                _CategorySection(title: "Home Essentials", categoryId: 7),
                _CategorySection(title: "Trending", categoryId: 7),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String title;
  final int categoryId;

  const _CategorySection({required this.title, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final products = state.products
              .where((p) => p.categoryId == categoryId)
              .toList();

          if (products.isEmpty) {
            return const SizedBox.shrink();
          }

          final crossAxisCount = context.isMobile
              ? 2
              : context.isTablet
              ? 3
              : 4;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: MaxWidth(
              maxwidth: 1200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _ProductCard(product: product);
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductEntity product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/product/id', extra: product),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: (product.images.isNotEmpty)
                    ? Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 40),
                      )
                    : const Image(
                        image: AssetImage('images/shoe1.jpg'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
