import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:intl/intl.dart';

final productProvider = FutureProvider.family<Product, String>((
  ref,
  productId,
) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.fetchProductById(productId);
});

class ProductComponent extends ConsumerWidget {
  const ProductComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productId = ref.watch(selectedProductProvider);
    if (productId == null) {
      return const Center(child: Text('Product is not selected'));
    }
    final product = ref.watch(productProvider(productId));
    return product.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data:
          (product) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  // horizontal: 16,
                  // vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(product.imageUrl),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              product.publishedDate.toDate() != null
                                  ? DateFormat(
                                    'yyyy-MM-dd HH:mm',
                                  ).format(product.publishedDate.toDate())
                                  : 'No date',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        Text(product.description),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
