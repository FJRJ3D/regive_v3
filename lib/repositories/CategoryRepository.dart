import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regive_v3/models/ProductCategory.dart';
import 'package:regive_v3/models/Subcategory.dart';

class CategoryRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ProductCategory>> fetchCategoriesWithSubcategories() async {
    try {
      final categoriesSnapshot = await firestore.collection('categories').get();
      final subcategoriesSnapshot = await firestore.collection('subcategories').get();

      final categoryList = categoriesSnapshot.docs.map((doc) => ProductCategory.fromDocumentSnapshot(doc)).toList();
      final subcategoryList = subcategoriesSnapshot.docs.map((doc) => Subcategory.fromDocumentSnapshot(doc)).toList();

      for (var category in categoryList) {
        category.subcategoryList = subcategoryList.where((subcategory) => subcategory.categoryId == category.id)
            .toList();
      }

      print("${categoryList}");
      return categoryList;
    } catch (e) {
      throw Exception('Failed to fetch categories and subcategories: $e');
    }
  }
}
