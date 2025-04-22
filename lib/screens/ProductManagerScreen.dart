import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/ProductCard.dart';
import 'package:regive_v3/components/SearchComponent.dart';
import 'package:regive_v3/components/custom_show_modal_bottom_sheet.dart';
import 'package:regive_v3/repositories/product_repository.dart';

class ProductManagerScreen extends ConsumerWidget {
  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProductsAsync = ref.watch(getAllUserProductsProvider);

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SearchComponent(),
                const SizedBox(height: 20),
                userProductsAsync.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                  data: (products) {
                    if (products.isEmpty) {
                      return const Center(child: Text("No products found."));
                    }
                    return Column(
                      children:
                          products
                              .map((product) => ProductCard(product: product))
                              .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
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
