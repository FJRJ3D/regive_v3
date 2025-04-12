import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/subcategory_repository.dart';
import '../models/Subcategory.dart';

class SubcategoryComponent extends ConsumerWidget {
  const SubcategoryComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCategoryData = ref.watch(activeCategoryDataProvider);
    final categoryId = activeCategoryData['id'] as String?;
    final categoryName = activeCategoryData['categoryName'] as String?;

    if (categoryId == null || categoryName == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final subcategoriesAsync = ref.watch(
      fetchSubcategoriesByCategoryIdProvider(categoryId),
    );

    return subcategoriesAsync.when(
      data:
          (subcategoriesList) => Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double itemWidth = 100;
                        final int crossAxisCount =
                            (constraints.maxWidth / itemWidth).floor();

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    crossAxisCount > 0 ? crossAxisCount : 1,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                                childAspectRatio: 3.5,
                              ),
                          itemCount: subcategoriesList.length,
                          itemBuilder: (context, index) {
                            final subcategory = subcategoriesList[index];
                            return InkWell(
                              onTap: () {
                                print(
                                  "Tapped on subcategory ${subcategory.name}",
                                );
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "> ${subcategory.name}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
