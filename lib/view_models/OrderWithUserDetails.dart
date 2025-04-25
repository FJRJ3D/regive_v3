import 'package:regive_v3/models/ProductOrder.dart';
import 'package:regive_v3/models/UserDetails.dart';

class OrderWithUserDetails {
  final ProductOrder productOrder;
  final UserDetails? userDetails;

  OrderWithUserDetails({required this.productOrder, required this.userDetails});
}