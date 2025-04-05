import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:regive_v3/models/ProductCategory.dart';
import 'package:regive_v3/models/Subcategory.dart';
import '../repositories/CategoryRepository.dart';
import '../components/SubcategoriesComponent.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());
final categoriesProvider = FutureProvider<List<ProductCategory>>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.fetchCategoriesWithSubcategories();
});

class CategoriesComponent extends ConsumerStatefulWidget {
  const CategoriesComponent({super.key});

  @override
  _CategoriesComponentState createState() => _CategoriesComponentState();
}

class _CategoriesComponentState extends ConsumerState<CategoriesComponent> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        return Column(
          children: [
            // Categories grid (4 per row)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.1,
                crossAxisSpacing: 8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategoryId == category.id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedCategoryId == category.id) {
                        selectedCategoryId = null;
                      } else {
                        selectedCategoryId = category.id;
                      }
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: isSelected ? Colors.blue[200] : Colors.blue[100],
                        backgroundImage: category.imageUrl != null
                            ? NetworkImage(category.imageUrl!)
                            : const AssetImage('assets/no_image.png') as ImageProvider,
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            if (selectedCategoryId != null)
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SubcategoryComponent(
                        subcategoryList: categories
                            .firstWhere((cat) => cat.id == selectedCategoryId)
                            .subcategoryList ?? [],
                        categoryName: categories.firstWhere((category) => category.id == selectedCategoryId)
                      .name,
                    ),
                  ],
                ),
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}