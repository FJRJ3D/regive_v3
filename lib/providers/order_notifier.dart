
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/order_repository.dart';
import 'package:regive_v3/services/order_service.dart';
import 'package:regive_v3/view_models/OrderWithProduct.dart';

class OrderNotifier extends StateNotifier<List<OrderWithProduct>> {
  final OrderService orderService;
  final Ref ref;
  bool _isLoading = false;

  OrderNotifier(this.orderService, this.ref) : super([]) {
    print('OrderNotifier initialized with empty state');
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await ref.read(deleteOrderByIdProvider(orderId));
      state = state.where((order) => order.productOrder.id != orderId).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteOrdersByProductId() async {
    try {
      final productId = ref.read(selectedProductProvider);
      state = state.where((order) => order.productOrder.productId != productId).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> loadMoreOrders() async {
    if(_isLoading) {
      print('Load more orders');
      return;
    }

    _isLoading = true;

    try {
      final newOrders = await orderService.fetchOrderWithProduct(ref);

      final uniqueNewOrders = newOrders.where((newOrders) {
        bool isDuplicate = state.any((existingOrder) => existingOrder.productOrder == newOrders.productOrder.id);

        return !isDuplicate;
      }).toList();

      if(uniqueNewOrders.isNotEmpty) {
        state = [...state, ...uniqueNewOrders];
      }
    } catch (error) {
      print('Error loading more products: $error');
    } finally {
      _isLoading = false;
      print('Loading process completed');
    }
  }
}