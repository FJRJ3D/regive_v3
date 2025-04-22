import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';
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
      ref
          .read(lastProductDocProvider.notifier)
          .state =
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

  Future<List<Product>> fetchProductsBySearch(Ref ref) async {
    final inputtedText = ref.watch(inputtedTextToSearchProvider);
    final categoryId = ref.watch(selectedCategoryIdProvider);
    print("categoryId: $categoryId");
    final subcategoryId = ref.watch(selectedSubcategoryIdProvider);
    print("subcategoryId: $subcategoryId");
    final lastDocument = ref.read(lastProductSearchedDocProvider);
    print("last document: $lastDocument");
    if(inputtedText == null && categoryId == null && subcategoryId == null) {
      throw Exception('everything is null');
    }
    final wordsSplit;
    Query<Map<String, dynamic>> query = firestore.collection('products').limit(
        5);
    if (inputtedText != null) {
      final inputtedTextLowCase = inputtedText.toLowerCase();
      wordsSplit = inputtedTextLowCase
          .split(' ')
          .map((word) => word.trim())
          .where((word) => word.isNotEmpty)
          .toList();
      if (wordsSplit.isNotEmpty) {
        query = query.where('keywords', arrayContainsAny: wordsSplit);
        print("add inputted text");
      }
    }
    if (lastDocument != null) {
      query = query = query.startAfterDocument(lastDocument);
      print("add lass document");
    }
    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
      print("add category id");
    }
    if (subcategoryId != null) {
      query = query.where('subcategoryId', isEqualTo: subcategoryId);
      print("add subcategory id");
    }
    final productsSnapshot = await query.limit(5).get();
    if (productsSnapshot.docs.isNotEmpty) {
      ref
          .read(lastProductSearchedDocProvider.notifier)
          .state =
          productsSnapshot.docs.last;
    }

    final productList = productsSnapshot.docs
        .map((doc) => Product.formDocumentSnapshot(doc))
        .toList();
    print(productList.map((product) => product.name));
    print(productList.map((product) => product.categoryId));
    return productList;
  }

  Future<List<Product>> fetchProductsByIdsList(List<String> ids) async {
    print('Fetching products for IDs: $ids');
    if (ids.isEmpty) return [];

    final futures = ids
        .map((id) => firestore.collection('products').doc(id).get())
        .toList();

    final snapshots = await Future.wait(futures);
    print('Received snapshots: ${snapshots.length}');

    final products = snapshots.map((doc) {
      final data = doc.data();
      if (data == null) {
        return null;
      }
      try {
        final product = Product.formDocumentSnapshot(doc);
        print('Parsed product: ${product.id}');
        return product;
      } catch (e) {
        print('Error parsing product ${doc.id}: $e');
        return null;
      }
    }).whereType<Product>().toList();

    print('Fetched products: $products');
    return products;
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

@riverpod
Future<List<Product>> fetchProductsBySearch(FetchProductsBySearchRef ref) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fetchProductsBySearch(ref);
}

@riverpod
Future<List<Product>> fetchProductsByIdsList(FetchProductsByIdsListRef ref, List<String> ids) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fetchProductsByIdsList(ids);
}