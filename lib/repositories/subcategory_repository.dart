
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regive_v3/models/Subcategory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subcategory_repository.g.dart';

class SubcategoryRepository {
  final FirebaseFirestore firestore;

  SubcategoryRepository(this.firestore);

  Future<List<Subcategory>> fetchSubcategoriesByCategoryId(String categoryId) async {
      final subcategoriesSnapshot = await firestore.collection('subcategories').where('categoryId', isEqualTo: categoryId).get();
      final subcategoryList = subcategoriesSnapshot.docs.map((doc) => Subcategory.fromDocumentSnapshot(doc)).toList();
      return subcategoryList;
  }

  Future<Subcategory> fetchSubcategoryById(String subcategoryId) async {
    final subcategoryDoc = await firestore.collection('subcategories').doc(subcategoryId).get();
    return Subcategory.fromDocumentSnapshot(subcategoryDoc);
  }
}

@riverpod
SubcategoryRepository subcategoryRepository(SubcategoryRepositoryRef ref) {
  return SubcategoryRepository(FirebaseFirestore.instance);
}

@riverpod
Future<List<Subcategory>> fetchSubcategoriesByCategoryId(FetchSubcategoriesByCategoryIdRef ref, String categoryId) async {
  final repo = ref.watch(subcategoryRepositoryProvider);
  return repo.fetchSubcategoriesByCategoryId(categoryId);
}

@riverpod
Future<Subcategory> fetchSubcategoryById(FetchSubcategoryByIdRef ref, String subcategoryId) {
  final repo = ref.watch(subcategoryRepositoryProvider);
  return repo.fetchSubcategoryById(subcategoryId);
}