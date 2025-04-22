import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/providers/global_providers.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(100),
        onTap: () {
          ref.read(activeProductOwnerProvider.notifier).state = product.userId;
          ref.read(selectedProductProvider.notifier).state = product.id;
          ref.read(productNameProvider.notifier).state = product.name;
          ref.read(productDescriptionProvider.notifier).state = product.description;
          ref.read(productImageUrlProvider.notifier).state = product.imageUrl;
          ref.read(capturedImageProvider.notifier).state = null;
          ref.read(selectedCategoryIdProvider.notifier).state = product.categoryId;
          ref.read(selectedSubcategoryIdProvider.notifier).state = product.subcategoryId;
          ref.read(createProductUpdateProviderBool.notifier).state = false;
          GoRouter.of(context).push('/product-details');
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              color: Colors.white,
            ),
            width: double.infinity,
            height: 140,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.43,
                          height: double.infinity,
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.43,
                          height: double.infinity,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  DateFormat(
                                    'yyyy-MM-dd HH:mm',
                                  ).format(product.publishedDate.toDate()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8D8D8D),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Color(0xFF8D8D8D)),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Orders: 5",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xFF8D8D8D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
