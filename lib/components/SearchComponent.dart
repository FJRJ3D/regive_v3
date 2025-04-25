import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/providers/global_providers.dart';

class SearchComponent extends ConsumerStatefulWidget {
  const SearchComponent({super.key});

  @override
  ConsumerState<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends ConsumerState<SearchComponent> {
  final TextEditingController _controller = TextEditingController();

  void _startSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      print('Search: $query');
      ref.read(inputtedTextToSearchProvider.notifier).state = query;
      ref.read(lastProductSearchedDocProvider.notifier).state = null;
      ref.read(selectedSubcategoryIdProvider.notifier).state =
      null;
      ref.read(selectedCategoryIdProvider.notifier).state =
      null;
      GoRouter.of(context).push('/search');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: ' Search...',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _startSearch(),
            ),
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: _startSearch),
        ],
      ),
    );
  }
}
