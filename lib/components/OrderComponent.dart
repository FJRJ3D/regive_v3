import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/order_repository.dart';

class OrderComponent extends ConsumerWidget {
  const OrderComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdFuture = ref.watch(getUserIdProvider.future);
    final productId = ref.watch(selectedProductProvider);

    return FutureBuilder(
      future: userIdFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData || productId == null) {
          return const SizedBox.shrink();
        }

        final userId = snapshot.data!;
        final existsFuture = ref.watch(orderExistsProvider(userId, productId).future);

        return FutureBuilder<bool>(
          future: existsFuture,
          builder: (context, orderSnapshot) {
            final alreadyOrdered = orderSnapshot.data == true;

            return Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  onPressed: alreadyOrdered ? null : () => _handleOrderPressed(context, ref),
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    backgroundColor: alreadyOrdered ? Colors.grey[400] : null,
                  ),
                  child: Text(
                    alreadyOrdered ? 'Ordered' : 'Order',
                    style: const TextStyle(
                      fontSize: 23,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleOrderPressed(BuildContext context, WidgetRef ref) async {
    final userId = await ref.read(getUserIdProvider.future);
    final productId = ref.read(selectedProductProvider);

    if (userId == null || productId == null) {
      _showSnackBar(context, "Missing user or product ID");
      return;
    }

    final exists = await ref.read(orderExistsProvider(userId, productId).future);
    if (exists) {
      _showSnackBar(context, "You have already ordered this product");
    } else {
      _showBottomSheet(context, ref);
    }
  }

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Order a product', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Write your reason',
                  contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await _orderProduct(controller.text, ref);
                _showSnackBar(context, result);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[100],
                foregroundColor: Colors.black54,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text('Order', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _orderProduct(String reason, WidgetRef ref) async {
    final userId = await ref.read(getUserIdProvider.future);
    final productId = ref.read(selectedProductProvider);

    if (userId == null || productId == null) {
      return "Error: Missing user or product ID";
    }

    return await ref.read(createAnOrderProvider(userId, productId, reason).future);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
