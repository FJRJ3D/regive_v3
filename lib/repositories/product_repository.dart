import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/compress_image.dart';
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
    if (inputtedText == null) {
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
    Query<Map<String, dynamic>> query = firestore.collection('products').where(
        'keywords', arrayContainsAny: wordsSplit).limit(5);
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final productsSnapshot = await query.get();
    ref
        .read(lastProductSearchedDocProvider.notifier)
        .state = productsSnapshot.docs.last;
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
Future<Product> fetchProductById(FetchProductByIdRef ref,
    String productId,) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fetchProductById(productId);
}

@riverpod
Future<List<Product>> fetchProductsBySearch(
    FetchProductsBySearchRef ref) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fetchProductsBySearch(ref);
}

@riverpod
Future<Product> createProductWithCurrentUser(Ref ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('No user is currently signed in');
  }

  final capturedImage = ref.read(capturedImageProvider);
  if (capturedImage == null) {
    throw Exception('No image captured');
  }
  final originalFile = File(capturedImage.path);
  final compressedFile = await compressImage(originalFile);

  String name = ref.read(productNameProvider);
  String description = ref.read(productDescriptionProvider);

  final firestore = FirebaseFirestore.instance.collection('products').doc();
  final generatedId = firestore.id;

  final newProduct = Product(
      id: generatedId,
      name: name,
      description: description,
      publishedDate: Timestamp.now(),
      imageUrl: await uploadImage(compressedFile, user),
      userId: user.uid,
      keywords: []);

  await firestore.set(newProduct.toMap());

  return newProduct;
}

Future<String> uploadImage (File image, User user) async {
  final String namefile = image.path.split("/").last;

  final Reference storageRef = FirebaseStorage.instance
      .ref()
      .child(user.uid)
      .child("images")
      .child(namefile);

  final UploadTask uploadTask = storageRef.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  return url;
}

@riverpod
Stream<List<Product>> getAllUserProducts(Ref ref)  {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('There is no authenticated user.');
  }

  final userId = user.uid;

  return FirebaseFirestore.instance
      .collection('products')
      .where('userId', isEqualTo: userId)
      .orderBy('publishedDate', descending: true)
      .limit(10)
      .snapshots()
      .map((querySnapshot) =>
      querySnapshot.docs.map(Product.formDocumentSnapshot).toList());
}
