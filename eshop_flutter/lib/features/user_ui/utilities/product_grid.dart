import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop_flutter/core/layout/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shop/product/domain/entities/product_entity.dart';

class ProductGrid extends StatefulWidget {
  final List<ProductEntity> products;
  final String? title;

  const ProductGrid({
    super.key,
    required this.products,
    this.title = 'Top Collection',
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    // Determine items per slide based on screen size
    final itemsPerSlide = context.isMobile
        ? 2
        : context.isTablet
        ? 3
        : 5;

    // Calculate number of slides needed
    final totalSlides = (widget.products.length / itemsPerSlide).ceil();

    if (widget.products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title ?? 'Featured Products',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (totalSlides > 1)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all products page
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
            ],
          ),
        ),
        // Carousel Slider
        CarouselSlider.builder(
          options: CarouselOptions(
            height: context.isMobile ? 200 : 320,
            autoPlay: true,
            viewportFraction: 1.0,
            enableInfiniteScroll: widget.products.length > itemsPerSlide,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlide = index;
              });
            },
          ),
          itemCount: totalSlides,
          itemBuilder: (context, slideIndex, realIndex) {
            final startIndex = slideIndex * itemsPerSlide;
            final endIndex = (startIndex + itemsPerSlide).clamp(
              0,
              widget.products.length,
            );
            final slideProducts = widget.products.sublist(startIndex, endIndex);
            final emptySlots = itemsPerSlide - slideProducts.length;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  ...slideProducts.map((product) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _ProductCard(product: product),
                      ),
                    );
                  }).toList(),
                  if (emptySlots > 0)
                    ...List.generate(
                      emptySlots,
                      (index) => const Expanded(child: SizedBox()),
                    ),
                ],
              ),
            );
          },
        ),
        // Pagination Dots
        if (totalSlides > 1)
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalSlides, (index) {
                return Container(
                  width: _currentSlide == index ? 24.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 2.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentSlide == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.go(
            '/product/id',
            extra: product,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.grey.shade200,
                child: (product.images.isNotEmpty)
                    ? Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('images/shoe1.jpg'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      )
                    : const Image(
                        image: AssetImage('images/shoe1.jpg'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
            ),
            // Product Info
            Expanded(
              flex: context.isMobile ? 2 : 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.isMobile ? 14 : 16,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border_sharp,
                            size: context.isMobile ? 18 : 24,
                          ),
                          onPressed: () {
                            // Handle favorite button press
                          },
                        ),
                      ],
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const Spacer(),
                    // if (product.sizes.isNotEmpty)
                    //   Text(
                    //     'Sizes: ${product.sizes.join(", ")}',
                    //     style: Theme.of(context).textTheme.bodySmall,
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
