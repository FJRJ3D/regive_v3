import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regive_v3/models/Order.dart';

part 'order_repository.g.dart';

class OrderRepository {
  final FirebaseFirestore firestore;

  OrderRepository(this.firestore);

  Future<String> createAnOrder(String userId, String productId, String reason) async {
    final orderRef = firestore.collection('orders').doc();

    final orderData = {
      'id': orderRef.id,
      'isAccepted': false,
      'isFinished': false,
      'reason': reason,
      'productId': productId,
      'userId': userId,
    };
    await orderRef.set(orderData);
    return 'Order was created';
  }
}

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepository(FirebaseFirestore.instance);
}

@riverpod
Future<String> createAnOrder(CreateAnOrderRef ref, String userId, String productId, String reason) {
  final repo = ref.watch(orderRepositoryProvider);
  return repo.createAnOrder(userId, productId, reason);
}
