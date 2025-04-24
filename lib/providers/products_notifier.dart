import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';

class ProductsNotifier extends StateNotifier<List<ProductWithUser>> {
  final ProductService productService;
  final Ref ref;
  bool _isLoading = false;

  ProductsNotifier(this.productService, this.ref) : super([]) {
    print(" ProductsNotifier initialized with empty state");
  }

  Future<void> loadMoreProducts() async {
    if (_isLoading) {
      print("Load more products skipped - loading in progress");
      return;
    }

    _isLoading = true;
    print("Start loading more products. Current state count: ${state.length}");

    try {
      final newProducts = await productService.fetchProductsWithUsers(ref);
      print("Fetched ${newProducts.length} new products from service");

      final uniqueNewProducts = newProducts.where((newProduct) {
        bool isDuplicate = state.any((existingProduct) =>
        existingProduct.product.id == newProduct.product.id);

        return !isDuplicate;
      }).toList();

      if (uniqueNewProducts.isNotEmpty) {
        state = [...state, ...uniqueNewProducts];
      }
    } catch (error) {
      print("Error loading more products: $error");
    } finally {
      _isLoading = false;
      print("Loading process completed");
    }
  }

  Future<void> deleteProduct() async {
    try {
      final productId = ref.read(selectedProductProvider);
      await ref.read(deleteProductProvider);
      state = state.where((product) => product.product.id != productId).toList();
    } catch (error) {
      rethrow;
    }
  }
}