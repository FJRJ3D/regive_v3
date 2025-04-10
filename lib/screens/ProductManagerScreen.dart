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
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(100),
                onTap: () {
                  print("boton presionado");
                },
                child: Padding(
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
                            Stack(
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * 0.43,
                                  height: double.infinity,
                                  child: Image.network(
                                    'https://www.shutterstock.com/image-photo/collage-set-little-boys-autumn-260nw-2354637183.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.43,
                                  height: double.infinity,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 25,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(150),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        "Ropa de niño 10 años",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "25/03/2025",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF8D8D8D),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Lote compuesto por  - chándal, pantalón con bolsillos y sudadera de cremallera ( la parte de delante tiene un mínimo...",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF8D8D8D),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "Orders: 5",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF8D8D8D),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
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
