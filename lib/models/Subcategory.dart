import 'package:cloud_firestore/cloud_firestore.dart';

class Subcategory {
  final String id;
  final String name;
  final String categoryId;

  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'categoryId': categoryId};
  }

  factory Subcategory.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Subcategory(
      id: doc.id,
      name: data['name'],
      categoryId: data['categoryId'],
    );
  }

  factory Subcategory.fromMap(Map<String, dynamic> map) {
    return Subcategory(
      id: map['id'],
      name: map['name'],
      categoryId: map['categoryId'],
    );
  }
}
