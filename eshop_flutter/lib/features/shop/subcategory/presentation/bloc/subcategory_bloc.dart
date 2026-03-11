import 'package:eshop_flutter/features/shop/subcategory/domain/repository/subcategory_repository.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/bloc/subcategory_event.dart';
import 'package:eshop_flutter/features/shop/subcategory/presentation/bloc/subcategory_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcategoryBloc extends Bloc<SubcategoryEvent, SubcategoryState> {
  final SubcategoryRepository repository;

  SubcategoryBloc(this.repository) : super(SubcategoryInitial()) {
    on<SubcategoryFetch>(_onSubcategoryFetch);
    on<CreateSubcategory>(_onCreateSubcategory);
    on<UpdateSubcategory>(_onUpdateSubcategory);
    on<DeleteSubcategory>(_onDeleteSubcategory);
  }

  Future<void> _onSubcategoryFetch(
    SubcategoryFetch event,
    Emitter<SubcategoryState> emit,
  ) async {
    emit(SubcategoryLoading());
    final result = await repository.getAllSubcategories(event.categoryId);
    result.fold(
      (failure) =>
          emit(const SubcategoryError('Failed to fetch subcategories')),
      (subcategories) => emit(SubcategoryLoaded(subcategories)),
    );
  }

  Future<void> _onCreateSubcategory(
    CreateSubcategory event,
    Emitter<SubcategoryState> emit,
  ) async {
    emit(SubcategoryLoading());
    final result = await repository.createSubcategory(event.subcategory);
    result.fold(
      (failure) => emit(const SubcategoryError('Failed to create subcategory')),
      (subcategory) => add(SubcategoryFetch(subcategory.categoryId)),
    );
  }

  Future<void> _onUpdateSubcategory(
    UpdateSubcategory event,
    Emitter<SubcategoryState> emit,
  ) async {
    emit(SubcategoryLoading());
    final result = await repository.updateSubcategory(event.subcategory);
    result.fold(
      (failure) => emit(const SubcategoryError('Failed to update subcategory')),
      (subcategory) => add(SubcategoryFetch(subcategory.categoryId)),
    );
  }

  Future<void> _onDeleteSubcategory(
    DeleteSubcategory event,
    Emitter<SubcategoryState> emit,
  ) async {
    final currentState = state;
    emit(SubcategoryLoading());
    final result = await repository.deleteSubcategory(event.id);
    result.fold(
      (failure) => emit(const SubcategoryError('Failed to delete subcategory')),
      (success) => (currentState is SubcategoryLoaded)
          ? emit(
              SubcategoryLoaded(
                currentState.subcategories
                    .where((s) => s.id != event.id)
                    .toList(),
              ),
            )
          : null,
    );
  }
}
