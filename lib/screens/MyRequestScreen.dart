import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyRequestScreen extends ConsumerWidget {
  const MyRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('My Request Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Ir a otra pantalla'),
        ),
      ),
    );
  }
}
