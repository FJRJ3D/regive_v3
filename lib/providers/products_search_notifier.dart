
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';

class ProductSearchNotifier extends StateNotifier<List<ProductWithUser>> {
  final ProductService productService;
  final Ref ref;
  bool _isLoading = false;

  ProductSearchNotifier(this.productService, this.ref) : super ([]) {
    print('Product search notifier initialized with empty state');
  }

  Future<void> loadMoreSearchedProducts() async {
    if(_isLoading) {
      return;
    }

    _isLoading = true;

    try {
      final newSearchedProducts = await productService.fetchProductWithUserBySearch(ref);
      final uniqueNewSearchedProducts = newSearchedProducts.where((newSearchedProducts) {
        bool isDuplicate = state.any((existsSearchingProduct) => existsSearchingProduct.product.id == newSearchedProducts.product.id);
        return !isDuplicate;
      }).toList();

    if (uniqueNewSearchedProducts.isNotEmpty) {
      state = [...state, ...uniqueNewSearchedProducts];
    }
    } catch (error) {
      throw Exception('Error loading more products: $error');
    } finally {
      _isLoading = false;
      print('Loading process completed');
    }
  }
}