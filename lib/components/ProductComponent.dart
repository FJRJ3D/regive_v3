import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:intl/intl.dart';

class ProductComponent extends ConsumerWidget {
  const ProductComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productId = ref.watch(selectedProductProvider);
    if (productId == null) {
      return const Center(child: Text('Product is not selected'));
    }

    final product = ref.watch(fetchProductByIdProvider(productId));

    return product.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (product) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey[50]
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.amber.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                  ),
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) => const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment(-1.0, -0.3),
                              end: Alignment(1.0, 0.3),
                            colors: [
                              Colors.white.withOpacity(0.0),
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: [0.35, 0.5, 0.65],
                          ),
                        ),
                      ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                                    'dd/MM/yyyy',
                                  ).format(product.publishedDate.toDate())
                                  : 'No date',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                        ),
                      ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
