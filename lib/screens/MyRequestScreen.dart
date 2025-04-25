import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/ProductCard.dart';
import 'package:regive_v3/providers/global_providers.dart';

class MyRequestScreen extends ConsumerStatefulWidget {
  const MyRequestScreen({super.key});

  @override
  ConsumerState<MyRequestScreen> createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends ConsumerState<MyRequestScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(orderNotifierProvider.notifier).loadMoreOrders();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(orderNotifierProvider.notifier).loadMoreOrders();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderWithProduct = ref.watch(orderNotifierProvider);
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
           child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'My requests',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final order = orderWithProduct[index];
            final product = order.product!;
            String orderStatus;
            if (order.productOrder.isAccepted == true &&
                order.productOrder.isFinished == true) {
              orderStatus = 'Accepted';
            } else if (!order.productOrder.isAccepted &&
                order.productOrder.isFinished) {
              orderStatus = 'Canceled';
            } else {
              orderStatus = 'Waiting';
            }
            return ProductCard(
              product: product,
              status: orderStatus,
              orderId: order.productOrder.id,
            );
          }, childCount: orderWithProduct.length),
        ),
      ],
    );
  }
}
