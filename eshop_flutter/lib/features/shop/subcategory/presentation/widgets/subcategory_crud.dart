import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_bloc.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_state.dart';
import 'package:eshop_flutter/features/shop/subcategory/domain/entites/subcategory_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/subcategory_bloc.dart';
import '../bloc/subcategory_event.dart';
import '../bloc/subcategory_state.dart';

class SubcategoryCrudPanel extends StatelessWidget {
  const SubcategoryCrudPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubcategoryBloc, SubcategoryState>(
      builder: (context, state) {
        if (state is SubcategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubcategoryLoaded) {
          return Column(
            children: [
              ElevatedButton.icon(
                onPressed: () => _showCreateDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Subcategory'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.subcategories.length,
                  itemBuilder: (context, index) {
                    final sub = state.subcategories[index];
                    return ListTile(
                      title: Text(sub.name),
                      subtitle: Text(sub.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showEditDialog(context, sub),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                context.read<SubcategoryBloc>().add(
                                  DeleteSubcategory(sub.id),
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is SubcategoryError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showCreateDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final imageCtrl = TextEditingController();
    int? selectedCategoryId;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create Subcategory'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: imageCtrl,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
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
                    onChanged: (val) => selectedCategoryId = val,
                  );
                }
                return const SizedBox.shrink();
              },
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
              if (selectedCategoryId != null) {
                final sub = SubcategoryEntity(
                  id: 0,
                  name: nameCtrl.text,
                  description: descCtrl.text,
                  imageUrl: imageCtrl.text,
                  categoryId: selectedCategoryId!,
                );
                context.read<SubcategoryBloc>().add(CreateSubcategory(sub));
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, SubcategoryEntity sub) {
    final nameCtrl = TextEditingController(text: sub.name);
    final descCtrl = TextEditingController(text: sub.description);
    final imageCtrl = TextEditingController(text: sub.imageUrl);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit ${sub.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: imageCtrl,
              decoration: const InputDecoration(labelText: 'Image URL'),
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
              final updated = SubcategoryEntity(
                id: sub.id,
                name: nameCtrl.text,
                description: descCtrl.text,
                imageUrl: imageCtrl.text,
                categoryId: sub.categoryId,
              );
              context.read<SubcategoryBloc>().add(UpdateSubcategory(updated));
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
