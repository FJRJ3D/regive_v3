import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:regive_v3/models/ProductCategory.dart';
import 'package:regive_v3/models/Subcategory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

class CategoryRepository {
  final FirebaseFirestore firestore;

  CategoryRepository(this.firestore);

  Future<List<ProductCategory>> fetchAllCategories() async {
      final categoriesSnapshot = await firestore.collection('categories').get();
      final categoryList = categoriesSnapshot.docs.map((doc) => ProductCategory.fromDocumentSnapshot(doc)).toList();
      return categoryList;
  }

  Future<ProductCategory> fetchCategoryById(String categoryId) async {
    final categoryDoc = await firestore.collection('categories').doc(categoryId).get();
    return ProductCategory.fromDocumentSnapshot(categoryDoc);
  }
}

@riverpod
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  return CategoryRepository(FirebaseFirestore.instance);
}

@riverpod
Future<List<ProductCategory>> fetchAllCategories(FetchAllCategoriesRef ref) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.fetchAllCategories();
}

@riverpod
Future<ProductCategory> fetchCategoryById(FetchCategoryByIdRef ref, String categoryId) {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.fetchCategoryById(categoryId);
}
