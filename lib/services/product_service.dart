import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/models/UserDetails.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_service.g.dart';

class ProductService {
  final ProductRepository productRepository;
  final UserDetailsRepository userDetailsRepository;

  ProductService({
    required this.productRepository,
    required this.userDetailsRepository,
  });

  Future<List<ProductWithUser>> fetchProductsWithUsers(Ref ref) async {
    final productList = await productRepository.fetchLatestProducts(ref);
   return _formObjectProductWithUserByProductList(productList);
  }

  Future<List<ProductWithUser>> fetchProductWithUserBySearch(Ref ref) async {
    final productList = await productRepository.fetchProductsBySearch(ref);
    print("you have recieved objects: ${productList.length}");
    return _formObjectProductWithUserByProductList(productList);
  }

  Future<List<ProductWithUser>> _formObjectProductWithUserByProductList(List<Product> productList) async {
    final userIds = productList.map((product) => product.userId).toSet().toList();
    final userDetailsList = await userDetailsRepository.fetchUserDetailsByUserIdsList(userIds);

    final userMap = {
      for (var userDetails in userDetailsList) userDetails.userId: userDetails,
    };

    final productWithUserList = productList.map((product) {
      final user = userMap[product.userId];
      return ProductWithUser(product: product, userDetails: user);
    }).toList();
    return productWithUserList;
  }
}


@riverpod
ProductService productService(ProductServiceRef ref) {
  return ProductService(
    productRepository: ref.watch(productRepositoryProvider),
    userDetailsRepository: ref.watch(userDetailsRepositoryProvider),
  );
}

@riverpod
Future<List<ProductWithUser>> fetchProductsWithUsers(FetchProductsWithUsersRef ref) async {
  final service = ref.watch(productServiceProvider);
  return service.fetchProductsWithUsers(ref);
}

@riverpod
Future<List<ProductWithUser>> fetchProductWithUserBySearch(FetchProductWithUserBySearchRef ref, String inputtedText) async {
  final service = ref.watch(productServiceProvider);
  return service.fetchProductWithUserBySearch(ref);
}
