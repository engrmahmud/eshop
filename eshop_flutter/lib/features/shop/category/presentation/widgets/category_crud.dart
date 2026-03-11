import 'package:eshop_flutter/core/layout/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';
import '../../domain/entities/category_entity.dart';

class CategoryCrudPanel extends StatelessWidget {
  const CategoryCrudPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return MaxWidth(
            maxwidth: 1200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showCreateDialog(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Category'),
                    ),

                    SearchBar(
                      constraints: BoxConstraints(
                        maxWidth: context.isMobile ? 300 : 500,
                        minHeight: context.isMobile ? 35 : 50,
                      ),
                      leading: const Icon(Icons.search),
                      hintText: 'Search',
                      onChanged: (value) {
                        context.read<CategoryBloc>().add(SearchCategory(value));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final cat = state.categories[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            cat.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontSize: context.isMobile ? 14 : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          subtitle: Text(cat.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showEditDialog(context, cat),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    context.read<CategoryBloc>().add(
                                      DeleteCategory(cat.id),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showCreateDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final priorityCtrl = TextEditingController();
    final imageCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create Category'),
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
              controller: priorityCtrl,
              decoration: const InputDecoration(labelText: 'Priority'),
              keyboardType: TextInputType.number,
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
              final cat = CategoryEntity(
                id: 0,
                name: nameCtrl.text,
                description: descCtrl.text,
                priority: int.tryParse(priorityCtrl.text) ?? 0,
                imageUrl: imageCtrl.text,
              );
              context.read<CategoryBloc>().add(CreateCategory(cat));
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, CategoryEntity cat) {
    final nameCtrl = TextEditingController(text: cat.name);
    final descCtrl = TextEditingController(text: cat.description);
    final priorityCtrl = TextEditingController(text: cat.priority.toString());
    final imageCtrl = TextEditingController(text: cat.imageUrl);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit ${cat.name}'),
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
              controller: priorityCtrl,
              decoration: const InputDecoration(labelText: 'Priority'),
              keyboardType: TextInputType.number,
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
              final updated = CategoryEntity(
                id: cat.id,
                name: nameCtrl.text,
                description: descCtrl.text,
                priority: int.tryParse(priorityCtrl.text) ?? cat.priority,
                imageUrl: imageCtrl.text,
              );
              context.read<CategoryBloc>().add(UpdateCategory(updated));
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
