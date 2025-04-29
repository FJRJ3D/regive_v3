import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/models/UserDetails.dart';
import 'package:regive_v3/providers/global_providers.dart';

class OrderCard extends ConsumerWidget {
  final UserDetails userDetails;
  final String? status;
  final String? orderId;
  final String selectedOrderId;

  const OrderCard({
    Key? key,
    required this.userDetails,
    this.status,
    this.orderId,
    required this.selectedOrderId,
  }) : super(key: key);

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
                  onTap: () {
                    final current = ref.read(selectedOrderIdProvider);
                    ref.read(selectedOrderIdProvider.notifier).state =
                        current == userDetails.id ? '' : userDetails.id;
                  },
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
                                        userDetails.imageUrl,
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
                                      userDetails.username,
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
                                            userDetails.wasOnline.toDate(),
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
                            if (userDetails.id == selectedOrderId)
                              // const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 15,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Necesito este lote de ropa para mi sobrino que acaba de cumplir 4 años.",
                                          style: TextStyle(
                                            color: Color(0xFF636363),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withAlpha(100),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Message",
                                                  hintText: "Write",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(Icons.send),
                                                    onPressed: () {
                                                      print("Send message");
                                                    },
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CustomElevatedButton(
                                            text: "Accept",
                                            onPressed: () {
                                              print("buttom pressed");
                                            },
                                            backgroundColor: const Color(
                                              0xFFE66A35,
                                            ),
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
