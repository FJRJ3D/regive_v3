import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/services/product_service.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';

final productsWithUsersProvider = FutureProvider<List<ProductWithUser>>((ref) async {
    final productRepo = ProductRepository(FirebaseFirestore.instance);
    final userDetailsRepo = UserDetailsRepository(FirebaseFirestore.instance);

    final productService = ProductService(productRepository: productRepo, userDetailsRepository: userDetailsRepo);
    return await productService.fetchProductsWithUsers();
});