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
  List<dynamic> keywords = extractKeywords(name);

  String? categoryId = ref.read(selectedCategoryIdProvider);
  String? subcategoryId = ref.read(selectedSubcategoryIdProvider);

  final firestore = FirebaseFirestore.instance.collection('products').doc();
  final generatedId = firestore.id;

  final newProduct = Product(
      id: generatedId,
      name: name,
      description: description,
      publishedDate: Timestamp.now(),
      imageUrl: await uploadImage(compressedFile, user),
      userId: user.uid,
      categoryId: categoryId!,
      subcategoryId: subcategoryId!,
      keywords: keywords);

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

List<dynamic> extractKeywords(String input) {
  return input
      .split(' ')
      .map((word) => word.toLowerCase())
      .toList();
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

@riverpod
Future<void> deleteProduct(Ref ref) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    final productDoc = await FirebaseFirestore.instance.collection('products').doc(ref.read(selectedProductProvider)).get();

    if (!productDoc.exists) {
      throw Exception('The product does not exist');
    }

    final productData = productDoc.data();
    final productUserId = productData?['userId'];

    if (productUserId != user.uid) {
      throw Exception('You do not have permission to delete this product');
    }

    final imageUrl = productData?['imageUrl'];
    if (imageUrl != null) {
      final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();
    }

    await productDoc.reference.delete();
  } catch (e) {
    throw Exception('Could not delete the product');
  }
}

// @riverpod
// Future<void> updateProduct(Ref ref) async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     throw Exception('No user is currently signed in');
//   }
//
//   final productRef = FirebaseFirestore.instance.collection('products').doc(ref.read(selectedProductProvider));
//
//   final productDoc = await productRef.get();
//   if (!productDoc.exists) {
//     throw Exception('The product does not exist');
//   }
//
//   final productData = productDoc.data();
//   if (productData == null) {
//     throw Exception('No product data found');
//   }
//
//   final productUserId = productData['userId'];
//
//   if (productUserId != user.uid) {
//     throw Exception('You do not have permission to delete this product');
//   }
//
//   String name = ref.read(productNameProvider);
//   String description = ref.read(productDescriptionProvider);
//   String? categoryId = ref.read(selectedCategoryIdProvider);
//   String? subcategoryId = ref.read(selectedSubcategoryIdProvider);
//   final productImageUrlFromProvider = ref.read(productImageUrlProvider);
//   final currentImageUrlFromFirestore = productData['imageUrl'] as String? ?? '';
//
//   String finalImageUrl;
//
//   if (productImageUrlFromProvider == currentImageUrlFromFirestore) {
//     finalImageUrl = currentImageUrlFromFirestore;
//   } else {
//     final capturedImage = ref.read(capturedImageProvider);
//     if (capturedImage == null) {
//       throw Exception('No image captured');
//     }
//     final originalFile = File(capturedImage.path);
//     final compressedFile = await compressImage(originalFile);
//     finalImageUrl = await uploadImage(compressedFile, user);
//   }
//
//   final updatedData = {
//     'name': name,
//     'description': description,
//     'publishedDate': Timestamp.now(),
//     'imageUrl': finalImageUrl,
//     'categoryId': categoryId,
//     'subcategoryId': subcategoryId,
//     'keywords': extractKeywords(name),
//   };
//
//   await productRef.update(updatedData);
// }

@riverpod
Future<void> updateProduct(Ref ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('No user is currently signed in');
  }

  final productRef = FirebaseFirestore.instance.collection('products').doc(ref.read(selectedProductProvider));

  final productDoc = await productRef.get();
  if (!productDoc.exists) {
    throw Exception('The product does not exist');
  }

  final productData = productDoc.data();
  if (productData == null) {
    throw Exception('No product data found');
  }

  final productUserId = productData['userId'];

  if (productUserId != user.uid) {
    throw Exception('You do not have permission to delete this product');
  }

  String name = ref.read(productNameProvider);
  String description = ref.read(productDescriptionProvider);
  String? categoryId = ref.read(selectedCategoryIdProvider);
  String? subcategoryId = ref.read(selectedSubcategoryIdProvider);
  final capturedImage = ref.watch(capturedImageProvider);

  String finalImageUrl;

  if (capturedImage != null) {
    final capturedImage = ref.read(capturedImageProvider);
    if (capturedImage == null) {
      throw Exception('No image captured');
    }
    final originalFile = File(capturedImage.path);
    final compressedFile = await compressImage(originalFile);
    finalImageUrl = await uploadImage(compressedFile, user);
  } else if (ref.read(productImageUrlProvider).isNotEmpty) {
    finalImageUrl = ref.read(productImageUrlProvider);
  }else {
    throw Exception('No image provided for the product');
  }

  final updatedData = {
    'name': name,
    'description': description,
    'publishedDate': Timestamp.now(),
    'imageUrl': finalImageUrl,
    'categoryId': categoryId,
    'subcategoryId': subcategoryId,
    'keywords': extractKeywords(name),
  };

  await productRef.update(updatedData);
}
