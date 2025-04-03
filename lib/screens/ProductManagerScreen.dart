import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductManagerScreen extends ConsumerWidget {
  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Manager Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Ir a otra pantalla'),
        ),
      ),
    );
  }
}
