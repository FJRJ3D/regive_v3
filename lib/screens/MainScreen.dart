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
    final productsWithUsers = ref.watch(productsNotifierProvider);

    return ListView.builder(
      controller: _scrollController,
      itemCount: productsWithUsers.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: SearchComponent(),
          );
        } else if (index == 1) {
          return Column(
            children: [
              const SizedBox(height: 8),
              CategoriesComponent(),
            ],
          );
        } else {
          final product = productsWithUsers[index - 2];
          return ProductWithOwnerComponent(item: product);
        }
      },
    );
  }
}
