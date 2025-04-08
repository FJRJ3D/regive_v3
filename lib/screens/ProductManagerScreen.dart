import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductManagerScreen extends ConsumerStatefulWidget {
  const ProductManagerScreen({super.key});

  @override
  ConsumerState<ProductManagerScreen> createState() =>
      _ProductManagerScreenState();
}

class _ProductManagerScreenState extends ConsumerState<ProductManagerScreen> {
  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: Column(
            children: [
              SvgPicture.asset('assets/ReGive_logo_horizontal.svg', width: 180),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFE0C0),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 700,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
