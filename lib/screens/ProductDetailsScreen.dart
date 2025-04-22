import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/components/OrderComponent.dart';
import 'package:regive_v3/components/OwnerComponent.dart';
import 'package:regive_v3/components/ProductComponent.dart';
import 'package:regive_v3/providers/global_providers.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showOwnerAndOrder = ref.read(showOwnerAndOrderProvider);

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
