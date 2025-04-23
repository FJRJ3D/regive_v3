import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/ProductOrder.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/order_repository.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/view_models/OrderWithProduct.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_service.g.dart';

class OrderService {
  final OrderRepository orderRepository;
  final ProductRepository productRepository;

  OrderService({
    required this.orderRepository,
    required this.productRepository,
  });

  Future<List<OrderWithProduct>> fetchOrderWithProduct(
    Ref ref,
  ) async {
    final userId = await ref.read(getUserIdProvider.future);
    print('user id: $userId}');
    if (userId == null) {
      throw Exception('You need to look in');
    }
    final orderList = await orderRepository.fetchOrdersByUserId(ref, userId);
    final productsIds = orderList.map((order) => order.productId).toList();
    final productList = await productRepository.fetchProductsByIdsList(
      productsIds,
    );

    final productMap = {for (var product in productList) product.id: product};

    final orderWithProductList =
        orderList.map((order) {
          final product = productMap[order.productId];
          return OrderWithProduct(productOrder: order, product: product);
        }).toList();
    return orderWithProductList;
  }
}

@riverpod
OrderService orderService(OrderServiceRef ref) {
  return OrderService(
    orderRepository: ref.watch(orderRepositoryProvider),
    productRepository: ref.watch(productRepositoryProvider),
  );
}

@riverpod
Future<List<OrderWithProduct>> fetchOrderWithProduct(FetchOrderWithProductRef ref, String userId) {
  final service = ref.watch(orderServiceProvider);
  return service.fetchOrderWithProduct(ref);
}
