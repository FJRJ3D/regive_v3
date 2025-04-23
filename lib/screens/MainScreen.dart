import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/CategoriesComponent.dart';
import 'package:regive_v3/components/ProductWithOwnerComponent.dart';
import 'package:regive_v3/components/SearchComponent.dart';
import 'package:regive_v3/providers/global_providers.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(productsNotifierProvider.notifier).loadMoreProducts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
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
    final productsWithUsers = ref.watch(productsNotifierProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF3E4CF),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding (
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: SearchComponent(),
      ),
            ),
            SliverToBoxAdapter(
              child: CategoriesComponent(),
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
