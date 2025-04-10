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
              padding: const EdgeInsets.only(bottom: 10),
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.43,
                          height: double.infinity,
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Huismus%2C_man.jpg/250px-Huismus%2C_man.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Lote compuesto por  - chándal, pantalón con bolsillos y sudadera de cremallera ( la parte de delante tiene un mínimo...",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(color: Color(0xFF8D8D8D)),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
