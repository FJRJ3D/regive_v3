import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductManagerScreen extends ConsumerWidget {
  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(alignment: Alignment.topLeft,child: SizedBox(
      height: 50, // Ajustamos la altura
      width: 200, // Aumentamos el ancho
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Establecemos el color azul
          elevation: 10, // Añadimos una sombra
          shadowColor: Colors.black, // Puedes cambiar el color de la sombra
        ),
        child: Text('Ir a otra pantalla'),
      ),
    )

    );
  }
}
