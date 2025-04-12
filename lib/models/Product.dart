import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final Timestamp publishedDate;
  final String imageUrl;
  final String userId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.publishedDate,
    required this.imageUrl,
    required this.userId,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'publishedDate': publishedDate,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }

  factory Product.formDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Product(id: doc.id, name: data['name'], description: data['description'], publishedDate: data['publishedDate'], imageUrl: data['imageUrl'], userId: data['userId']);
  }

}