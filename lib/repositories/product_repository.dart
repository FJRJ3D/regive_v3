import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository(this.firestore);

  Future<List<Product>> fetchLatestProducts() async {
    try {
      final productsSnapshot = await firestore.collection('products').orderBy('publishedDate', descending: true).limit(10).get();
      final productList = productsSnapshot.docs.map((doc) => Product.formDocumentSnapshot(doc)).toList();
      return productList;
    } catch (error) {
      throw Exception('Failed to fetch latest products: ${error}');
    }
  }
}

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository(FirebaseFirestore.instance);
}
