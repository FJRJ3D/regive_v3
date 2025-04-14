import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository(this.firestore);

  Future<List<Product>> fetchLatestProducts(Ref ref) async {
    final lastProductDoc = ref.read(lastProductDocProvider);
    print("products is started");
    QuerySnapshot<Map<String, dynamic>> productsSnapshot;
    if (lastProductDoc == null) {
      productsSnapshot =
          await firestore
              .collection('products')
              .orderBy('publishedDate', descending: true)
              .limit(5)
              .get();
    } else {
      productsSnapshot =
          await firestore
              .collection('products')
              .orderBy('publishedDate', descending: true)
              .startAfterDocument(lastProductDoc)
              .limit(5)
              .get();
    }
    if (productsSnapshot.docs.isNotEmpty) {
      ref.read(lastProductDocProvider.notifier).state =
          productsSnapshot.docs.last;
      print('last document saved');
    }
    final productList =
        productsSnapshot.docs
            .map((doc) => Product.formDocumentSnapshot(doc))
            .toList();
    return productList;
  }

  Future<Product> fetchProductById(String productId) async {
    final productDocument =
        await firestore.collection('products').doc(productId).get();
    final product = Product.formDocumentSnapshot(productDocument);
    return product;
  }
}

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository(FirebaseFirestore.instance);
}

@riverpod
Future<Product> fetchProductById(
  FetchProductByIdRef ref,
  String productId,
) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fetchProductById(productId);
}
