import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/utils/date_format.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';
import 'package:regive_v3/providers/global_providers.dart';

class ProductsComponent extends ConsumerWidget {
  final ProductWithUser item;

  const ProductsComponent({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = item.product.publishedDate;
    final publishedDate =
        date != null
            ? ref.watch(formatDateProvider(ref, date.toDate()))
            : 'No date';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          ref.read(activeProductOwnerProvider.notifier).state =
              item.product.userId;
          ref.read(selectedProductProvider.notifier).state = item.product.id;
          GoRouter.of(context).push('/product-details');
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              (item.userDetails?.imageUrl != null &&
                                      item.userDetails!.imageUrl.isNotEmpty)
                                  ? NetworkImage(item.userDetails!.imageUrl)
                                  : const AssetImage(
                                        'assets/images/default_user_photo.png',
                                      )
                                      as ImageProvider,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item.userDetails?.username ?? 'no name',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        publishedDate,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => const Center(
                          child: Icon(Icons.image_not_supported, size: 50),
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.product.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
