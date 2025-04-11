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

  Future<Product> fetchProductById(String productId) async {
      final productDocument = await firestore.collection('products').doc(productId).get();
      final product = Product.formDocumentSnapshot(productDocument);
      return product;
  }
}

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository(FirebaseFirestore.instance);
}

@riverpod
Future<Product> fetchProductById(FetchProductByIdRef ref, String productId) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fetchProductById(productId);
}
