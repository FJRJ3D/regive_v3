import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regive_v3/models/Subcategory.dart';

class ProductCategory {
  final String id;
  final String name;
  final String imageUrl;

  ProductCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory ProductCategory.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ProductCategory(
      id: doc.id,
      name: data['name'],
      imageUrl: data['imageUrl'],
    );
  }
}
