import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/providers/products_notifier.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';


final selectedProductProvider = StateProvider<String?>((ref) => null);

final activeProductOwnerProvider = StateProvider<String?>((ref) => null);

final activeCategoryDataProvider = StateProvider<Map<String, String?>>((ref) => {'id': null, 'categoryName': null,});

final lastProductDocProvider = StateProvider<DocumentSnapshot?>((ref) => null);

final productsNotifierProvider = StateNotifierProvider<ProductsNotifier, List<ProductWithUser>>(
      (ref) {
    final productService = ref.watch(productServiceProvider);
    return ProductsNotifier(productService, ref);
  },
);