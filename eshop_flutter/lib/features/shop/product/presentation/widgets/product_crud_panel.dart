import 'package:dio/dio.dart';
import 'package:eshop_flutter/core/layout/responsive.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_bloc.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_state.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_event.dart';
import 'package:eshop_flutter/features/shop/product/presentation/bloc/product_state.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/bloc/subcategory_bloc.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/bloc/subcategory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/product_bloc.dart';
import '../../domain/entities/product_entity.dart';

class ProductCrudPanel extends StatelessWidget {
  const ProductCrudPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _showCreateDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Product'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/admin/categories'),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Categories'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index]; // ProductEntity
                    return MaxWidth(
                      maxwidth: 1200,
                      child: Card(
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                            'Price: \$${product.price} | Qty: ${product.quantity}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _showEditDialog(context, product),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context.read<ProductBloc>().add(
                                    DeleteProduct(product.id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showCreateDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final priceController = TextEditingController();
    final discountController = TextEditingController();
    final qtyController = TextEditingController();
    bool isAvailable = true;
    int? selectedCategoryId;
    int? selectedSubcategoryId;
    List<String> images = [];
    final List<String> allSizes = ['S', 'M', 'L', 'XL', 'XXL'];
    final List<String> selectedSizes = [];
    final List<String> allColors = [
      'Red',
      'Blue',
      'Green',
      'Yellow',
      'Black',
      'White',
    ];
    final List<String> selectedColors = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.values[context.isMobile ? 0 : 1],
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: discountController,
                  decoration: const InputDecoration(labelText: 'Discount'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: qtyController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),

                // Category dropdown
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      return DropdownButton<int>(
                        value: selectedCategoryId,
                        hint: Text('Select Category'),
                        items: state.categories
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => setState(() {
                          selectedCategoryId = val;
                          selectedSubcategoryId =
                              null; // Reset subcategory when category changes
                        }),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Subcategory dropdown
                BlocBuilder<SubcategoryBloc, SubcategoryState>(
                  builder: (context, state) {
                    if (state is SubcategoryLoaded) {
                      // Filter subcategories by selected category
                      final filteredSubcategories = selectedCategoryId != null
                          ? state.subcategories
                                .where(
                                  (s) => s.categoryId == selectedCategoryId,
                                )
                                .toList()
                          : [];

                      return DropdownButton<int>(
                        value: selectedSubcategoryId,
                        hint: Text('Select Subcategory'),
                        disabledHint: selectedCategoryId == null
                            ? const Text('Select category first')
                            : Text(
                                filteredSubcategories.isEmpty
                                    ? 'No subcategories available'
                                    : 'Select Subcategory',
                              ),
                        items: filteredSubcategories
                            .map<DropdownMenuItem<int>>(
                              (s) => DropdownMenuItem<int>(
                                value: s.id,
                                child: Text(s.name),
                              ),
                            )
                            .toList(),
                        onChanged: selectedCategoryId != null
                            ? (val) => setState(() {
                                selectedSubcategoryId = val;
                              })
                            : null,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Image upload
                ElevatedButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final picked = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      // Upload to backend (via Dio)
                      final uploadedUrl = await uploadImageToServer(
                        picked.path,
                      );
                      setState(() {
                        images.add(uploadedUrl);
                      });
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Upload Image'),
                ),

                SwitchListTile(
                  title: const Text('Available'),
                  value: isAvailable,
                  onChanged: (val) => setState(() {
                    isAvailable = val;
                  }),
                ),
                // Size Dropdown
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Sizes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ...allSizes.map(
                  (size) => CheckboxListTile(
                    title: Text(size),
                    value: selectedSizes.contains(size),
                    onChanged: (val) => setState(() {
                      if (val == true) {
                        selectedSizes.add(size);
                      } else {
                        selectedSizes.remove(size);
                      }
                    }),
                  ),
                ),
                const SizedBox(height: 8),
                // Color dropdown
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Colors',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ...allColors.map(
                  (color) => CheckboxListTile(
                    title: Text(color),
                    value: selectedColors.contains(color),
                    onChanged: (val) => setState(() {
                      if (val == true) {
                        selectedColors.add(color);
                      } else {
                        selectedColors.remove(color);
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate required fields
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product name is required')),
                  );
                  return;
                }
                if (selectedCategoryId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a category')),
                  );
                  return;
                }
                // if (selectedSubcategoryId == null) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Please select a subcategory'),
                //     ),
                //   );
                //   return;
                // }

                if (priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Price is required')),
                  );
                  return;
                }
                if (qtyController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Quantity is required')),
                  );
                  return;
                }

                final product = ProductEntity(
                  id: 0,
                  name: nameController.text,
                  description: descController.text,
                  price: double.tryParse(priceController.text) ?? 0,
                  discount: double.tryParse(discountController.text) ?? 0,
                  images: images,
                  sizes: selectedSizes,
                  colors: selectedColors,
                  quantity: int.tryParse(qtyController.text) ?? 0,
                  isAvailable: isAvailable,
                  categoryId: selectedCategoryId!,
                  subcategoryId: selectedSubcategoryId!,
                );
                context.read<ProductBloc>().add(CreateProduct(product));
                Navigator.pop(context);
              },
              child: const Text('Create Product'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> uploadImageToServer(String filePath) async {
  final dio = Dio();
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(filePath),
  });
  final response = await dio.post('http://our-server/upload', data: formData);
  return response
      .data['url']; // backend returns URL which will be stored in the postgresql database
}

void _showEditDialog(BuildContext context, ProductEntity product) {
  final nameController = TextEditingController(text: product.name);
  final priceController = TextEditingController(
    text: product.price.toString(),
  );
  final qtyController = TextEditingController(
    text: product.quantity.toString(),
  );
  final descController = TextEditingController(text: product.description);
  final discountController = TextEditingController(
    text: product.discount.toString(),
  );

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Edit ${product.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: discountController,
            decoration: const InputDecoration(labelText: 'Discount'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: qtyController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updated = ProductEntity(
              id: product.id,
              name: nameController.text,
              description: descController.text,
              price: double.tryParse(priceController.text) ?? product.price,
              discount:
                  double.tryParse(discountController.text) ?? product.discount,
              images: product.images,
              sizes: product.sizes,
              colors: product.colors,
              quantity: int.tryParse(qtyController.text) ?? product.quantity,
              isAvailable: product.isAvailable,
              categoryId: product.categoryId,
              subcategoryId: product.subcategoryId,
            );
            context.read<ProductBloc>().add(UpdateProduct(updated));
            Navigator.pop(context);
          },
          child: const Text('Update Product'),
        ),
      ],
    ),
  );
}
