
import 'package:regive_v3/models/UserDetails.dart';
import 'package:regive_v3/repositories/product_repository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';

class ProductService {
  final ProductRepository productRepository;
  final UserDetailsRepository userDetailsRepository;

  ProductService({required this.productRepository,
  required this.userDetailsRepository,});

  Future<List<ProductWithUser>> fetchProductsWithUsers() async {
    final productList = await productRepository.fetchLatestProducts();
    final userIds = productList.map((product) => product.userId).toList();
    final userDetailsList = await userDetailsRepository.fetchUserDetailsByUserIdsList(userIds);

    final userMap = {
      for (var userDetails in userDetailsList) userDetails.id: userDetails,
    };

    return productList.map((product) {
      final user = userMap[product.userId];
      return ProductWithUser(product: product, userDetails: user);
    }).toList();
  }
}