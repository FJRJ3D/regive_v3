import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/utils/date_format.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';
import 'package:regive_v3/providers/global_providers.dart';

class ProductsComponent extends ConsumerWidget {
  const ProductsComponent({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(fetchProductsWithUsersProvider);

    return productAsync.when(
      data: (productsWithUsers) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productsWithUsers.length,
          itemBuilder: (context, index) {
            final item = productsWithUsers[index];
            final date = item.product.publishedDate;
            String publishedDate;
            if (date != null) {
              publishedDate = ref.watch(formatDateProvider(ref, date.toDate()));
            } else {
              publishedDate = 'No date';
            }

            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: GestureDetector(
                  onTap: () {
                    ref.read(activeProductOwnerProvider.notifier).state = item.product.userId;
                    ref.read(selectedProductProvider.notifier).state = item.product.id;
                    GoRouter.of(context).push('/product-details');
                  },
                child: Container(
                  width: double.infinity,
                  child: Column(

                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
