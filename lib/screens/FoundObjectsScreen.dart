import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    ref.read(productSearchNotifierProvider.notifier).loadMoreSearchedProducts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
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
      backgroundColor: const Color(0xFFF3E4CF),
      appBar: AppBar(
        title: const Text('Found Products'),
        backgroundColor: const Color(0xFFF3E4CF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/main');
          },
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SearchComponent(),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final product = productsWithUsers[index];
                  return ProductWithOwnerComponent(item: product);
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
