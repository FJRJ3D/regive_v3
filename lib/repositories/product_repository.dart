import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository(this.firestore);

  Future<List<Product>> fetchLatestProducts() async {
    try {
      final productsSnapshot =
          await firestore
              .collection('products')
              .orderBy('publishedDate', descending: true)
              .limit(10)
              .get();
      final productList =
          productsSnapshot.docs
              .map((doc) => Product.formDocumentSnapshot(doc))
              .toList();
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
Future<void> createProductWithCurrentUser(
    Ref ref, {
      required Product productRequest,
    }) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('No user is currently signed in');
  }

  // 1. Selecciona la imagen del dispositivo
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    throw Exception('No image selected');
  }

  // 2. Subir la imagen a Firebase Storage
  final storageRef = FirebaseStorage.instance.ref().child('product_images/${pickedFile.name}');
  final uploadTask = storageRef.putFile(File(pickedFile.path));

  // Espera a que el archivo se suba
  final taskSnapshot = await uploadTask.whenComplete(() {});

  // 3. Obtener la URL de la imagen subida
  final imageUrl = await taskSnapshot.ref.getDownloadURL();

  // 4. Crea el producto y guárdalo en Firestore
  final productRef = FirebaseFirestore.instance.collection('products').doc();

  await productRef.set({
    'name': productRequest.name,
    'description': productRequest.description,
    'publishedDate': Timestamp.now(),
    'imageUrl': imageUrl, // Usamos la URL del archivo subido
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
