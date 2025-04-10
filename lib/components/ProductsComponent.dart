import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/services/product_service_provider.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';
import 'package:regive_v3/providers/global_providers.dart';

class ProductsComponent extends ConsumerWidget {
  const ProductsComponent({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productsWithUsersProvider);

    return productAsync.when(
      data: (productsWithUsers) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productsWithUsers.length,
          itemBuilder: (context, index) {
            final item = productsWithUsers[index];

            String publishedDate =
            item.product?.publishedDate?.toDate() != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(item.product!.publishedDate!.toDate())
                : 'No date';

            return Center(
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedProductProvider.notifier).state = item.product.id;
                  GoRouter.of(context).push('/product-details');
            },
              child: Container(
                width: 500,
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: Container(
                              width: 200,
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: item.product?.imageUrl != null
                                      ? NetworkImage(item.product!.imageUrl!)
                                      : AssetImage('assets/images/no_image_photo.png') as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 55,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item.product.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: item.userDetails?.imageUrl != null
                                        ? NetworkImage(item.userDetails!.imageUrl!)
                                        : AssetImage('assets/images/default_user_photo.png') as ImageProvider,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item.userDetails?.username ?? 'no name',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    publishedDate,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item.product.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
