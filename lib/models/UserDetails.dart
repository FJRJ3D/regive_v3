import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String id;
  final String username;
  final String imageUrl;
  final Timestamp wasOnline;
  final String userId;

  UserDetails({
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.wasOnline,
    required this.userId,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': username,
      'imageUrl': imageUrl,
      'wasOnline': wasOnline,
      'userId': userId,
    };
  }

  factory UserDetails.formDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserDetails(id: doc.id, username: data['username'], imageUrl: data['imageUrl'], wasOnline: data['wasOnline'], userId: data['userId']);
  }
}