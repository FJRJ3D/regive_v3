import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:regive_v3/models/Product.dart';

class OrderCard extends ConsumerWidget {
  final Product product;
  final String? status;
  final String? orderId;

  const OrderCard({Key? key, required this.product, this.status, this.orderId})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10) +
          EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        color: Colors.transparent,
        elevation: 7,
        shadowColor: Colors.black.withAlpha(500),
        borderRadius: BorderRadius.circular(40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white.withAlpha(170),
              ),
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(100),
                  onTap: () {},
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 67,
                                      height: 67,
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
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
                                      product.name,
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
                                Expanded(
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          DateFormat('yyyy-MM-dd HH:mm').format(
                                            product.publishedDate.toDate(),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            color: Color(0xFF8D8D8D),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
