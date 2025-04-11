import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

@riverpod
Future<List<Product>> getAllUserProducts(Ref ref) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('There is no authenticated user.');
  }

  final userId = user.uid;

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('userDetailsId', isEqualTo: userId)
        .orderBy('publishedDate', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs
        .map((doc) => Product.formDocumentSnapshot(doc))
        .toList();
  } catch (e) {
    print('Error fetching user products: $e');
    return [];
  }
}
