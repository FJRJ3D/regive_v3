import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final bool isAccepted;
  final bool isFinished;
  final String reason;
  final String productId;
  final String userId;

  Order({
    required this.id,
    required this.isAccepted,
    required this.isFinished,
    required this.reason,
    required this.productId,
    required this.userId,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isAccepted': isAccepted,
      'isFinished': isFinished,
      'reason': reason,
      'productId': productId,
      'userId': userId,
    };
  }

  factory Order.formDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Order(id: doc.id, isAccepted: data['isAccepted'], isFinished: data['isFinished'], reason: data['reason'], productId: data['productId'], userId: data['userId']);
  }
}