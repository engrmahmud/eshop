import 'package:eshop_flutter/features/shop/category/domain/entities/category_entity.dart';
import 'package:eshop_flutter/features/shop/category/domain/repository/category_repository.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_event.dart';
import 'package:eshop_flutter/features/shop/category/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;
  List<CategoryEntity> _allCategories = [];

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CategoryFetch>(_onCategoryFetch);
    on<CreateCategory>(_onCreateCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<SearchCategory>(_onSearchCategory);
    on<GetCategoryById>(_onGetCategoryById);
  }

  Future<void> _onCategoryFetch(
    CategoryFetch event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await repository.getAllCategories();
    result.fold(
      (failure) => emit(CategoryError('Failed to fetch categories')),
      (categories) {
        _allCategories = categories;
        emit(CategoryLoaded(categories));
      },
    );
  }

  Future<void> _onCreateCategory(
    CreateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await repository.createCategory(event.category);
    result.fold(
      (failure) => emit(CategoryError('Failed to create category')),
      (category) => add(CategoryFetch()),
    );
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await repository.updateCategory(event.category);
    result.fold(
      (failure) => emit(CategoryError('Failed to update category')),
      (category) => add(CategoryFetch()),
    );
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await repository.deleteCategory(event.id);
    result.fold(
      (failure) => emit(CategoryError('Failed to delete category')),
      (success) => add(CategoryFetch()),
    );
  }

  void _onSearchCategory(
    SearchCategory event,
    Emitter<CategoryState> emit,
  ) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(CategoryLoaded(_allCategories));
    } else {
      final filteredList = _allCategories
          .where(
            (category) =>
                category.name.toLowerCase().contains(query) ||
                category.description.toLowerCase().contains(query),
          )
          .toList();
      emit(CategoryLoaded(filteredList));
    }
  }

  void _onGetCategoryById(
    GetCategoryById event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final category = _allCategories.firstWhere(
        (category) => category.id == event.id,
      );
      emit(CategoryLoaded([category]));
    } catch (e) {
      emit(CategoryError('Category not found'));
    }
  }
}
