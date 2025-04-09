import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/components/CustomTextField.dart';

class ProductManagerScreen extends ConsumerWidget {
  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Search a product',
              hintText: 'Enter a product name',
              prefixIcon: Icons.search,
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                ),
                width: double.infinity,
                height: 140,
                child: Row(
                  children: [
                    Container(
                      width: 185,
                      height: double.infinity,
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Huismus%2C_man.jpg/250px-Huismus%2C_man.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
