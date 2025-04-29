import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/category_repository.dart';
import 'package:regive_v3/repositories/subcategory_repository.dart';
import 'package:regive_v3/models/ProductCategory.dart';
import 'package:regive_v3/models/Subcategory.dart';

class CategorySelectorModal extends ConsumerStatefulWidget {
  const CategorySelectorModal({super.key});

  @override
  _CategorySelectorModalState createState() => _CategorySelectorModalState();
}

class _CategorySelectorModalState extends ConsumerState<CategorySelectorModal> {
  String? selectedCategoryId;
  String? selectedSubcategoryId;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(fetchAllCategoriesProvider);
    final subcategoriesAsync = selectedCategoryId != null
        ? ref.watch(fetchSubcategoriesByCategoryIdProvider(selectedCategoryId!))
        : null;

    return Container(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                categoriesAsync.when(
                  data: (categories) => DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedCategoryId,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Choose category'),
                    items: categories.map((ProductCategory cat) {
                      return DropdownMenuItem(
                        value: cat.id,
                        child: Text(cat.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                        selectedSubcategoryId = null;
                      });
                    },
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text('Error loading categories: $error'),
                ),
                const SizedBox(height: 24),
                if (selectedCategoryId != null) ...[
                  const Text('Select Subcategory', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  subcategoriesAsync!.when(
                    data: (subcategories) => DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: selectedSubcategoryId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Choose subcategory'),
                      items: subcategories.map((Subcategory subcat) {
                        return DropdownMenuItem(
                          value: subcat.id,
                          child: Text(subcat.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSubcategoryId = value;
                        });
                      },
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text('Error loading subcategories: $error'),
                  ),
                  const SizedBox(height: 24),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: (selectedCategoryId != null && selectedSubcategoryId != null)
                          ? () {
                        ref.read(selectedCategoryIdProvider.notifier).state = selectedCategoryId;
                        print('saved category id: $selectedCategoryId');
                        ref.read(selectedSubcategoryIdProvider.notifier).state = selectedSubcategoryId;
                        print('saved subcategory id: $selectedSubcategoryId');
                        Navigator.of(context).pop();
                      }
                          : null,
                      child: const Text('Confirm Selection'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
