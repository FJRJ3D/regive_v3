import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigurationScreen extends ConsumerWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuration Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Ir a otra pantalla'),
        ),
      ),
    );
  }
}
