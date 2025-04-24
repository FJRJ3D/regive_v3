import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final Timestamp publishedDate;
  final String imageUrl;
  final String userId;
  final String userDetailsId;
  final String categoryId;
  final String subcategoryId;
  final List<dynamic> keywords;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.publishedDate,
    required this.imageUrl,
    required this.userId,
    required this.userDetailsId,
    required this.categoryId,
    required this.subcategoryId,
    required this.keywords,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'publishedDate': publishedDate,
      'imageUrl': imageUrl,
      'userId': userId,
      'userDetailsId' : userDetailsId,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'keywords': keywords,
    };
  }

  factory Product.formDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};

    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      publishedDate: data['publishedDate'] ?? Timestamp.now(),
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
      userDetailsId: data['userDetailsId'] ?? '',
      categoryId: data['categoryId'] ?? '',
      subcategoryId: data['subcategoryId'] ?? '',
      keywords: data['keywords'] ?? [],
    );
  }


}