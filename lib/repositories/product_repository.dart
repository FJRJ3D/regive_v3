import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<List<Product>> fetchProductsBySearch(Ref ref) async {
    final inputtedText = ref.watch(inputtedTextToSearchProvider);
    if(inputtedText == null) {
      throw Exception("You can't search without white anything into input");
    }
    final lastDocument = ref.read(lastProductSearchedDocProvider);
    final inputtedTextLowCase = inputtedText.toLowerCase();
    final wordsSplit = inputtedTextLowCase
        .split(' ')
        .map((word) => word.trim())
        .where((word) => word.isNotEmpty)
        .toList();
    if (wordsSplit.isEmpty) {
      print("No valid search terms");
      throw Exception('Words are empty');
    }
    Query<Map<String, dynamic>> query = firestore.collection('products').where('keywords', arrayContainsAny: wordsSplit).limit(5);
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final productsSnapshot = await query.get();
    ref.read(lastProductSearchedDocProvider.notifier).state = productsSnapshot.docs.last;
    final productList =
    productsSnapshot.docs
        .map((doc) => Product.formDocumentSnapshot(doc))
        .toList();
    return productList;
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
Future<void> createProductWithCurrentUser(
    Ref ref, {
      required Product productRequest,
    }) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('No user is currently signed in');
  }

  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    throw Exception('No image selected');
  }

  final storageRef = FirebaseStorage.instance.ref().child('product_images/${pickedFile.name}');
  final uploadTask = storageRef.putFile(File(pickedFile.path));

  final taskSnapshot = await uploadTask.whenComplete(() {});

  final imageUrl = await taskSnapshot.ref.getDownloadURL();

  final productRef = FirebaseFirestore.instance.collection('products').doc();

  await productRef.set({
    'name': productRequest.name,
    'description': productRequest.description,
    'publishedDate': Timestamp.now(),
    'imageUrl': imageUrl,
    'userDetailsId': user.uid,
  });

  await productRef.update({
    'id': productRef.id,
  });
}

@riverpod
Future<List<Product>> getAllUserProducts(Ref ref) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('There is no authenticated user.');
  }

  final userId = user.uid;

  try {
    final querySnapshot =
    await FirebaseFirestore.instance
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
