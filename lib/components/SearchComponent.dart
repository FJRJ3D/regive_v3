import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/providers/global_providers.dart';

class SearchComponent extends ConsumerWidget {
  const SearchComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _goInput() {
      ref.read(lastProductSearchedDocProvider.notifier).state = null;
      ref.read(selectedSubcategoryIdProvider.notifier).state = null;
      ref.read(selectedCategoryIdProvider.notifier).state = null;
      ref.read(inputtedTextToSearchProvider.notifier).state = null;

      GoRouter.of(context).push('/search/input');
    }


    return GestureDetector(
      onTap: _goInput,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
        ),
        child: Row(
          children: [
            const Expanded(
              child: IgnorePointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: ' Search...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}
