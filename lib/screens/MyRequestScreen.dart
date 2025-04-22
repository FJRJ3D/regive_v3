import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/OrderWithProductComponent.dart';
import 'package:regive_v3/components/ProductWithOwnerComponent.dart';
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
    return Scaffold(
      backgroundColor: Color(0xFFF3E4CF),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final order = orderWithProduct[index];
                return OrderWithProductComponent(item: order);
              }, childCount: orderWithProduct.length),
            ),
          ],
        ),
      ),
    );
  }
}
