import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/category_repository.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/select_image.dart';
import 'package:regive_v3/repositories/subcategory_repository.dart';

void CustomShowModalBottomSheet(BuildContext context, WidgetRef ref) {

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
                      builder: (context, ref, child) {
                        return  ref.watch(fetchAllCategoriesProvider).when(
                          data: (categories) => DropdownButtonFormField<String>(
                            value: ref.watch(selectedCategoryIdProvider),
                            onChanged: (value) {
                              ref.read(selectedCategoryIdProvider.notifier).state = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Select Category',
                              labelStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.white.withAlpha(50),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: Colors.grey[900],
                            style: const TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.white,
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(category.name),
                              );
                            }).toList(),
                          ),
                          loading: () => const CircularProgressIndicator(),
                          error: (error, stack) => Text('Error: $error'),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Consumer(
                      builder: (context, ref, _) {
                        final selectedCategoryId = ref.watch(selectedCategoryIdProvider);
                        if (selectedCategoryId == null) {
                          return const SizedBox();
                        }
                        final subsAsync = ref.watch(fetchSubcategoriesByCategoryIdProvider(selectedCategoryId));
                        final selectedSubId = ref.watch(selectedSubcategoryIdProvider);
                        return subsAsync.when(
                          data: (subs) => DropdownButtonFormField<String>(
                            value: selectedSubId,
                            onChanged: (value) {
                              ref.read(selectedSubcategoryIdProvider.notifier).state = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Select Subcategory',
                              labelStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.white.withAlpha(50),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: Colors.grey[900],
                            style: const TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.white,
                            items: subs.map((sub) {
                              return DropdownMenuItem<String>(
                                value: sub.id,
                                child: Text(sub.name),
                              );
                            }).toList(),
                          ),
                          loading: () => const CircularProgressIndicator(),
                          error: (e, _) => Text('Error: $e'),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      text: 'Submit',
                      onPressed: () async {
                        await ref.read(createProductWithCurrentUserProvider.future,);
                        ref.read(capturedImageProvider.notifier).state = null;
                        ref.read(selectedCategoryIdProvider.notifier).state = null;
                        ref.read(selectedSubcategoryIdProvider.notifier).state = null;
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
