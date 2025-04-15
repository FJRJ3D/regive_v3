import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/components/CustomTextField.dart';
import 'package:regive_v3/components/ProductCard.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/select_image.dart';

class ProductManagerScreen extends ConsumerWidget {
  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProductsAsync = ref.watch(getAllUserProductsProvider);

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  labelText: 'Search a product',
                  hintText: 'Enter a product name',
                  prefixIcon: Icons.search,
                  keyboardType: TextInputType.text,
                ),
                userProductsAsync.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                  data: (products) {
                    if (products.isEmpty) {
                      return const Center(child: Text("No products found."));
                    }
                    return Column(
                      children:
                          products
                              .map((product) => ProductCard(product: product))
                              .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    45,
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
                                            ref
                                                .read(
                                                  capturedImageProvider
                                                      .notifier,
                                                )
                                                .state = image;
                                          },
                                          backgroundColor: Colors.grey
                                              .withAlpha(150),
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
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: 'Product name',
                                      labelStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      hintStyle: const TextStyle(
                                        color: Colors.white70,
                                      ),
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
                                    minLines: 3,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      hintText: 'Product description',
                                      labelStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      hintStyle: const TextStyle(
                                        color: Colors.white70,
                                      ),
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
                                  CustomElevatedButton(
                                    text: 'Submit',
                                    onPressed: () async {},
                                    backgroundColor: Colors.grey.withAlpha(150),
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
              },
              child: const Icon(Icons.add, size: 25, color: Colors.white),
              backgroundColor: const Color(0xFFE8763B),
              elevation: 10,
            ),
          ),
        ),
      ],
    );
  }
}
