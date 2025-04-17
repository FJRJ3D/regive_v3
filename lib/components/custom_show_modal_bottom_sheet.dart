import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/select_image.dart';

void CustomShowModalBottomSheet(BuildContext context, WidgetRef ref) {
  final List<String> categories = ['Books', 'Electronics', 'Animals', 'Decor', 'Hobby', 'Peoples help'];

  final Map<String, List<String>> categoryMap = {
    'Books': ['visual novel', 'Non‑fiction', 'manga', 'web novel', 'Adventure', 'Comics',],
    'Electronics': ['Smartphones', 'Laptops', 'Headphones', 'Tablets', 'Smartwatches',],
    'Animals': ['Pets', 'Wildlife', 'Marine Life', 'Birds', 'Reptiles',],
    'Decor': ['Furniture', 'Wall Art', 'Lighting', 'Rugs', 'Candles',],
    'Hobby': ['Photography', 'Fishing', 'Gardening', 'Painting', 'Collecting',],
    'Peoples help': ['Charity', 'Support Groups', 'Volunteering', 'Donations', 'Community Services',],
  };

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 45,
                  left: 16,
                  right: 16,
                  top: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "New Product",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final capturedImage = ref.watch(
                            capturedImageProvider,
                          );
                          return FloatingActionButton(
                            onPressed: () async {
                              final image = await ref.read(
                                getImageProvider.future,
                              );
                              ref.read(capturedImageProvider.notifier).state =
                                  image;
                            },
                            backgroundColor: Colors.grey.withAlpha(150),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (capturedImage != null)
                                  ClipOval(
                                    child: Image.file(
                                      File(capturedImage.path),
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                const Opacity(
                                  opacity: 0.4,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                              ],
                            ),
                            shape: const CircleBorder(),
                            elevation: 6,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged:
                          (value) =>
                              ref.read(productNameProvider.notifier).state =
                                  value,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Product name',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withAlpha(50),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged:
                          (value) =>
                              ref
                                  .read(productDescriptionProvider.notifier)
                                  .state = value,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Product description',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.description,
                          color: Colors.white,
                        ),
                        fillColor: Colors.white.withAlpha(50),
                        filled: true,
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Consumer(
                      builder: (context, ref, _) {
                        final selectedCategory = ref.watch(selectedCategoryProvider);
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withAlpha(50),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          dropdownColor: Colors.black.withAlpha(200),
                          isExpanded: true,
                          isDense: true,
                          value: selectedCategory,
                          hint: const Text("Select a category", style: TextStyle(color: Colors.white)),
                          iconEnabledColor: Colors.white,
                          items: categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category, style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          selectedItemBuilder: (context) {
                            return categories.map((category) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(category, style: const TextStyle(color: Colors.white)),
                              );
                            }).toList();
                          },
                          onChanged: (newVal) {
                            ref.read(selectedCategoryProvider.notifier).state = newVal;
                            ref.read(selectedSubcategoryProvider.notifier).state = null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Consumer(
                      builder: (context, ref, _) {
                        final selectedCategory = ref.watch(selectedCategoryProvider);
                        final selectedSub = ref.watch(selectedSubcategoryProvider);
                        final subList = selectedCategory != null
                            ? categoryMap[selectedCategory] ?? []
                            : <String>[];
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withAlpha(50),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          dropdownColor: Colors.black.withAlpha(200),
                          isExpanded: true,
                          isDense: true,
                          value: selectedSub,
                          hint: const Text("Select a subcategory", style: TextStyle(color: Colors.white)),
                          iconEnabledColor: Colors.white,
                          items: subList.map((sub) {
                            return DropdownMenuItem(
                              value: sub,
                              child: Text(sub, style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          selectedItemBuilder: (context) {
                            return subList.map((sub) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(sub, style: const TextStyle(color: Colors.white)),
                              );
                            }).toList();
                          },
                          onChanged: (newVal) {
                            ref.read(selectedSubcategoryProvider.notifier).state = newVal;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      text: 'Submit',
                      onPressed: () async {
                        await ref.read(
                          createProductWithCurrentUserProvider.future,
                        );
                        ref.read(capturedImageProvider.notifier).state = null;
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
