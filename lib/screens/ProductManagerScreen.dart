import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/CustomTextField.dart';
import 'package:regive_v3/components/ProductCard.dart';
import 'package:regive_v3/repositories/product_repository.dart';

class ProductManagerScreen extends ConsumerWidget {
  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProductsAsync = ref.watch(getAllUserProductsProvider);

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Search a product',
              hintText: 'Enter a product name',
              prefixIcon: Icons.search,
              keyboardType: TextInputType.text,
            ),
            userProductsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
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
    );
  }
}
