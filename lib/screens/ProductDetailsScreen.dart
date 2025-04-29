import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/components/OrderComponent.dart';
import 'package:regive_v3/components/OwnerComponent.dart';
import 'package:regive_v3/components/ProductComponent.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/order_repository.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showOwnerAndOrder = ref.read(showOwnerAndOrderProvider);
    final orderCountAsync = ref.watch(getOrderCountByProductProvider(ref.read(selectedProductProvider)!));

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFA354), Color(0xFFE56230)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/ReGive_logo_horizontal.svg',
                        width: 180,
                      ),
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0C0),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductComponent(),
                        if (showOwnerAndOrder) ...[
                          OwnerComponent(),
                          OrderComponent(),
                        ]else ...[
                          const SizedBox(height: 20),
                          Center(child: SizedBox(
                            width: 150,
                            child: CustomElevatedButton(
                              child: orderCountAsync.when(
                                data:
                                    (count) => Text(
                                  'Orders: $count',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                loading:
                                    () => Text(
                                  'Loading...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                error:
                                    (e, _) => Text(
                                  'Error',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                orderCountAsync.when(
                                  data: (count) {
                                    if (count == 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('There are no orders available.'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    } else {
                                      GoRouter.of(context).push('/orders');
                                    }
                                  },
                                  loading: () {
                                    print('Loading...');
                                  },
                                  error: (error, stack) {
                                    print('Error: $error');
                                  },
                                );
                              },
                              backgroundColor: const Color(0xFFE66A35),
                              foregroundColor: Colors.white,),
                          ),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
