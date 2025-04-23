import 'package:cloud_firestore/cloud_firestore.dart';

class ProductOrder {
  final String id;
  final bool isAccepted;
  final bool isFinished;
  final String reason;
  final String productId;
  final String userId;

  ProductOrder({
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

  factory ProductOrder.formDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ProductOrder(id: doc.id, isAccepted: data['isAccepted'], isFinished: data['isFinished'], reason: data['reason'], productId: data['productId'], userId: data['userId']);
  }
}