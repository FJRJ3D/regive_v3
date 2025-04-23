import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/ProductCard.dart';
import 'package:regive_v3/components/SearchComponent.dart';
import 'package:regive_v3/components/custom_show_modal_bottom_sheet.dart';
import 'package:regive_v3/providers/global_providers.dart';

class ProductManagerScreen extends ConsumerStatefulWidget {
  const ProductManagerScreen({super.key});

  @override
  ConsumerState<ProductManagerScreen> createState() =>
      _ProductManagerScreenState();
}

class _ProductManagerScreenState extends ConsumerState<ProductManagerScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ref.read(productsNotifierProvider.notifier).loadMoreProducts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
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

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding (
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                  child: SearchComponent(),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = userProductsAsync[index];
                    return ProductCard(product: product.product);
                  },
                  childCount: userProductsAsync.length,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                ref.read(productNameProvider.notifier).state = '';
                ref.read(productDescriptionProvider.notifier).state = '';
                ref.read(productImageUrlProvider.notifier).state = '';
                ref.read(capturedImageProvider.notifier).state = null;
                ref.read(selectedCategoryIdProvider.notifier).state = null;
                ref.read(selectedSubcategoryIdProvider.notifier).state = null;
                ref.read(createProductUpdateProviderBool.notifier).state = true;
                CustomShowModalBottomSheet(context, ref);
              },
              child: const Icon(Icons.add, size: 25, color: Colors.white),
              backgroundColor: const Color(0xFFE8763B),
              elevation: 10,
            ),
          ),
        ),
      ],
    );
  }
}
