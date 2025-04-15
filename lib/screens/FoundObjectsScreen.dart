import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/CategoriesComponent.dart';
import 'package:regive_v3/components/ProductWithOwnerComponent.dart';
import 'package:regive_v3/components/SearchComponent.dart';
import 'package:regive_v3/providers/global_providers.dart';

class FoundObjectsScreen extends ConsumerStatefulWidget {
  const FoundObjectsScreen({super.key});

  @override
  ConsumerState<FoundObjectsScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<FoundObjectsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(productsNotifierProvider.notifier).loadMoreProducts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      ref.read(productSearchNotifierProvider.notifier).loadMoreSearchedProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsWithUsers = ref.watch(productSearchNotifierProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF3E4CF),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SearchComponent(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final product = productsWithUsers[index];
                  return ProductsComponent(item: product);
                },
                childCount: productsWithUsers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
