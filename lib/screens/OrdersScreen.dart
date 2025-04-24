import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/OrderCard.dart';
import 'package:regive_v3/providers/global_providers.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ref.read(productsNotifierProvider.notifier).loadMoreProducts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(productsNotifierProvider.notifier).loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProductsAsync = ref.watch(productsNotifierProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 126),
      child: Align(
        alignment: Alignment.topCenter,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = userProductsAsync[index];
                return OrderCard(product: product.product);
              }, childCount: userProductsAsync.length),
            ),
          ],
        ),
      ),
    );
  }
}
