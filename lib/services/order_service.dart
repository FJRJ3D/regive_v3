import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/order_repository.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/view_models/OrderWithProduct.dart';
import 'package:regive_v3/view_models/OrderWithUserDetails.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_service.g.dart';

class OrderService {
  final OrderRepository orderRepository;
  final ProductRepository productRepository;
  final UserDetailsRepository userDetailsRepository;

  OrderService({
    required this.orderRepository,
    required this.productRepository,
    required this.userDetailsRepository,
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

  Future<List<OrderWithUserDetails>> fetchOrderWithUserDetails (Ref ref) async {
    final productId = ref.read(selectedProductProvider);
    if (productId == null) {
      throw Exception('productId is null');
    }
    final orderList = await orderRepository.fetchOrdersByProductId(ref, productId);
    final userIdList = orderList.map((order) => order.userId).toSet().toList();
    final userDetailsList = await userDetailsRepository.fetchUserDetailsByUserIdsList(userIdList);

    final userDetailsMap = {
      for (var details in userDetailsList) details.userId: details
    };

    final orderWithUserDetails = orderList.map((order) {
      final userDetails = userDetailsMap[order.userId];
      return OrderWithUserDetails(
        productOrder: order,
        userDetails: userDetails,
      );
    }).toList();
    return orderWithUserDetails;
  }
}

@riverpod
OrderService orderService(OrderServiceRef ref) {
  return OrderService(
    orderRepository: ref.watch(orderRepositoryProvider),
    productRepository: ref.watch(productRepositoryProvider),
    userDetailsRepository: ref.watch(userDetailsRepositoryProvider),
  );
}

@riverpod
Future<List<OrderWithProduct>> fetchOrderWithProduct(FetchOrderWithProductRef ref, String userId) {
  final service = ref.watch(orderServiceProvider);
  return service.fetchOrderWithProduct(ref);
}

@riverpod
Future<List<OrderWithUserDetails>> fetchOrderWithUserDetails (Ref ref) {
  final service = ref.watch(orderServiceProvider);
  return service.fetchOrderWithUserDetails(ref);
}
