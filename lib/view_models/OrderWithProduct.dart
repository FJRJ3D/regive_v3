import 'package:regive_v3/models/Product.dart';
import 'package:regive_v3/models/ProductOrder.dart';

class OrderWithProduct {
  final ProductOrder productOrder;
  final Product? product;

  OrderWithProduct({required this.productOrder, required this.product});
}