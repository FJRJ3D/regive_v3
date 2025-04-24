import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/components/custom_show_modal_bottom_sheet.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/repositories/category_repository.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:intl/intl.dart';
import 'package:regive_v3/repositories/subcategory_repository.dart';

class ProductComponent extends ConsumerWidget {
  const ProductComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showOwnerAndOrder = ref.read(showOwnerAndOrderProvider);
    final productId = ref.watch(selectedProductProvider);
    if (productId == null) {
      return const Center(child: Text('Product is not selected'));
    }

    final product = ref.watch(fetchProductByIdProvider(productId));
    return product.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (product) {
        final category = ref.watch(fetchCategoryByIdProvider(product.categoryId));
        final subcategory = ref.watch(fetchSubcategoryByIdProvider(product.subcategoryId));
        String categoryText = 'Loading category...';
        if (category is AsyncData && category.value != null) {
          categoryText = category.value!.name;
        } else if (category is AsyncError) {
          categoryText = 'No category';
        }

        String subcategoryText = 'Loading subcategory...';
        if (subcategory is AsyncData && subcategory.value != null) {
          subcategoryText = subcategory.value!.name;
        } else if (subcategory is AsyncError) {
          subcategoryText = 'No subcategory';
        }

        String? categoryIdSafe;
        if (category is AsyncData && category.value != null) {
          categoryIdSafe = category.value!.id;
        }

        String? subcategoryIdSafe;
        if (subcategory is AsyncData && subcategory.value != null) {
          subcategoryIdSafe = subcategory.value!.id;
        }

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
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                        const SizedBox(height: 10),
                        if (!showOwnerAndOrder) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, size: 30,),
                                color: Color(0xFF8D8D8D),
                                onPressed: () {
                                  CustomShowModalBottomSheet(context, ref);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, size: 30),
                                color: Color(0xFF8D8D8D),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                        'Are you sure you want to delete this product? This action cannot be undone.',
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
                                      actionsPadding: const EdgeInsets.only(bottom: 16),
                                      actions: [
                                        Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () => Navigator.of(context).pop(false),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFF8D8D8D),
                                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                onPressed: () => Navigator.of(context).pop(true),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFF8D8D8D),
                                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true) {
                                    try {
                                      await ref.read(deleteProductProvider);
                                      ref.read(productsNotifierProvider.notifier).deleteProduct();
                                      ref.read(orderNotifierProvider.notifier).deleteOrdersByProductId();
                                      GoRouter.of(context).pop();
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  ref.read(lastProductSearchedDocProvider.notifier).state = null;
                                  ref.read(inputtedTextToSearchProvider.notifier).state =
                                  null;
                                  ref.read(selectedSubcategoryIdProvider.notifier).state =
                                  null;
                                  ref.read(inputtedTextToSearchProvider.notifier).state = null;
                                  if (categoryIdSafe != null) {
                                    ref.read(selectedCategoryIdProvider.notifier).state = categoryIdSafe;
                                    GoRouter.of(context).push('/search');
                                  }
                                  GoRouter.of(context).push('/search');
                              },
                              child:
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              // margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "category: $categoryText",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                             onTap: () {
                               ref.read(lastProductSearchedDocProvider.notifier).state = null;
                               ref.read(inputtedTextToSearchProvider.notifier).state =
                               null;
                               ref.read(selectedCategoryIdProvider.notifier).state =
                               null;
                               ref.read(inputtedTextToSearchProvider.notifier).state = null;
                               if (subcategoryIdSafe != null) {
                                 ref.read(selectedSubcategoryIdProvider.notifier).state = subcategoryIdSafe;
                                 GoRouter.of(context).push('/search');
                               }
                               GoRouter.of(context).push('/search');
                             },
                              child:
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              // margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "subcategory: $subcategoryText",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ),
                          ],
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
