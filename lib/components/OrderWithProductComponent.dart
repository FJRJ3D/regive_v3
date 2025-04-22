import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/utils/date_format.dart';
import 'package:regive_v3/view_models/OrderWithProduct.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';
import 'package:regive_v3/providers/global_providers.dart';

class OrderWithProductComponent extends ConsumerWidget {
  final OrderWithProduct item;

  const OrderWithProductComponent({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = item.product!.publishedDate;
    final publishedDate =
        date != null
            ? ref.watch(formatDateProvider(ref, date.toDate()))
            : 'No date';

    String orderStatus = '';

    if (item.productOrder.isAccepted == true &&
        item.productOrder.isFinished == true) {
      orderStatus = 'Accepted';
    } else if (item.productOrder.isAccepted == false &&
        item.productOrder.isFinished == true) {
      orderStatus = 'Canceled';
    } else {
      orderStatus = 'Waiting';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          ref.read(activeProductOwnerProvider.notifier).state =
              item.product!.userId;
          ref.read(selectedProductProvider.notifier).state = item.product!.id;
          GoRouter.of(context).push('/product-details');
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.product!.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      // flex: 1,
                      child:
                      // Column(
                      //   // crossAxisAlignment: CrossAxisAlignment.stretch,
                      //   children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column( children: [


                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(
                                  publishedDate,
                                  style: TextStyle(fontSize: 15),
                                ),
                                  ],
                                ),
                              ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product!.description,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],),

                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      orderStatus,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                        //   ),
                        // ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product!.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.product!.description,
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
