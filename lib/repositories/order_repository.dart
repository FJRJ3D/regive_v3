import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regive_v3/models/ProductOrder.dart';

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

  Future<List<ProductOrder>> fetchOrdersByUserId(Ref ref, String userId) async {
    final lastOrderDoc = ref.read(lastOrderDocProvider);
    Query<Map<String, dynamic>> query = firestore.collection('orders').where('userId', isEqualTo: userId);
    if(lastOrderDoc != null) {
      query = query.startAfterDocument(lastOrderDoc);
      print('add to firebase last doc');
    }
    final ordersDoc = await query.limit(5).get();
    if (ordersDoc.docs.isNotEmpty) {
      ref.read(lastOrderDocProvider.notifier).state = ordersDoc.docs.last;
      print('add last doc');
    }
    final orderList = ordersDoc.docs.map((doc) => ProductOrder.formDocumentSnapshot(doc)).toList();
    print('order list: $orderList');
    return orderList;
  }

  Future<void> deleteOrderById(String orderId) async {
    return firestore.collection('orders').doc(orderId).delete();
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

@riverpod
Future<List<ProductOrder>> fetchOrdersByUserId(FetchOrdersByUserIdRef ref, String userId) async{
  final repo = ref.watch(orderRepositoryProvider);
  return repo.fetchOrdersByUserId(ref, userId);
}

@riverpod
Future<void> deleteOrderById(DeleteOrderByIdRef ref, String orderId) async {
  final repo = ref.watch(orderRepositoryProvider);
  return repo.deleteOrderById(orderId);
}

@riverpod
Future<int> getOrderCountByProduct(Ref ref, String productId) async {

  final querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('productId', isEqualTo: productId)
      .get();

  return querySnapshot.size;
}
