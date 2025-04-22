import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/products_notifier.dart';
import 'package:regive_v3/providers/products_search_notifier.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';
import 'package:image_picker/image_picker.dart';

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

final lastProductSearchedDocProvider = StateProvider<DocumentSnapshot?>((ref) => null);

final inputtedTextToSearchProvider = StateProvider<String?>((ref) => null);

final productSearchNotifierProvider = StateNotifierProvider<ProductSearchNotifier, List<ProductWithUser>>(
    (ref) {
      final productService = ref.watch(productServiceProvider);
      return ProductSearchNotifier(productService, ref);
    },
);

final capturedImageProvider = StateProvider<XFile?>((ref) => null);

final productNameProvider = StateProvider<String>((ref) => '');

final productDescriptionProvider = StateProvider<String>((ref) => '');

final productImageUrlProvider = StateProvider<String>((ref) => '');

final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);

final selectedSubcategoryIdProvider = StateProvider<String?>((ref) => null);

final showOwnerAndOrderProvider = StateProvider<bool>((ref) => true);

final createProductUpdateProviderBool = StateProvider<bool>((ref) => true);
