import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String id;
  final String username;
  final String imageUrl;

  UserDetails({
    required this.id,
    required this.username,
    required this.imageUrl,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': username,
      'imageUrl': imageUrl,
    };
  }

  factory UserDetails.formDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserDetails(id: doc.id, username: data['username'], imageUrl: data['imageUrl']);
  }
}