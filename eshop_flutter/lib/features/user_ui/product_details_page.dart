import 'package:eshop_flutter/core/layout/responsive.dart';
import 'package:eshop_flutter/features/shop/product/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedImageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;

  @override
  void initState() {
    super.initState();
    if (widget.product.sizes.isNotEmpty) {
      _selectedSize = widget.product.sizes.first;
    }
    if (widget.product.colors.isNotEmpty) {
      _selectedColor = widget.product.colors.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
        ),

        actions: [
          IconButton(
            onPressed: () {
              context.go('/cart');
            },
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: MaxWidth(
          maxwidth: 1200,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageGallery(context),
                      const SizedBox(height: 24),
                      _buildProductInfo(context),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildImageGallery(context),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 3,
                        child: _buildProductInfo(context),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: (widget.product.images.isNotEmpty)
                  ? Image.network(
                      widget.product.images[_selectedImageIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 50),
                    )
                  : const Image(
                      image: AssetImage('images/shoe1.jpg'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (widget.product.images.length > 1)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.product.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedImageIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.product.images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // Colors
        if (widget.product.colors.isNotEmpty) ...[
          Text('Color', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: widget.product.colors.map((color) {
              return ChoiceChip(
                label: Text(color),
                selected: _selectedColor == color,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedColor = color;
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],

        // Sizes
        if (widget.product.sizes.isNotEmpty) ...[
          Text('Size', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: widget.product.sizes.map((size) {
              return ChoiceChip(
                label: Text(size),
                selected: _selectedSize == size,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedSize = size;
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],

        // Add to Cart Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Implement add to cart logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to cart!')),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: textTheme.titleMedium,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Description
        Text('Description', style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          widget.product.description,
          style: textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 24),

        // Reviews
        Text('Reviews', style: textTheme.titleLarge),
        const SizedBox(height: 8),
        // Implement review list
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('No reviews yet.'),
          ),
        ),
      ],
    );
  }
}
