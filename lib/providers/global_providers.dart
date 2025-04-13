import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/Product.dart';


final selectedProductProvider = StateProvider<String?>((ref) => null);

final activeProductOwnerProvider = StateProvider<String?>((ref) => null);

final activeCategoryDataProvider = StateProvider<Map<String, String?>>((ref) => {'id': null, 'categoryName': null,});

final lastProductDocProvider = StateProvider<DocumentSnapshot?>((ref) => null);

