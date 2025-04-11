import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/order_repository.dart';

class OrderComponent extends ConsumerWidget {
  const OrderComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () => _showBottomSheet(context, ref),
        style: ElevatedButton.styleFrom(
          // primary: Colors.amber, // Button color
          // onPrimary: Colors.black87, // Text color
          elevation: 5, // Shadow depth
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
        ),
        child: const Text(
          'Order',
          style: TextStyle(
              fontSize: 23,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            // left: 16,
            // right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order a product',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: 'Write your reason',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 5,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final enteredText = controller.text;
                      final result = await _orderProduct(enteredText, ref);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(result)));
                      Navigator.pop(context);
                    },
                    child: const Text('Order', style: TextStyle(fontSize: 16)),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(double.infinity, 50),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.amber[100],
                      ), // Колір фону кнопки
                      foregroundColor: MaterialStateProperty.all(
                        Colors.black54,
                      ), // Колір тексту кнопки
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> _orderProduct(String reason, WidgetRef ref) async {
    print("you have ordered an object with description ${reason}");
    final userId = await ref.read(getUserIdProvider.future);
    final productId = ref.read(selectedProductProvider);
    if (userId == null || productId == null) {
      return "Error: Missing user or product ID";
    }
    final response = await ref.read(
      createAnOrderProvider(userId, productId, reason).future,
    );
    return response;
  }
}
