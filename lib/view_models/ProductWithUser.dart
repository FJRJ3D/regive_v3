
import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/models/UserDetails.dart';

class ProductWithUser {
  final Product product;
  final UserDetails? userDetails;

  ProductWithUser({required this.product, required this.userDetails});
}