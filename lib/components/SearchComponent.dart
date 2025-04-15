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
    if(query.isNotEmpty) {
      print('Search: $query');
      ref.read(inputtedTextToSearchProvider.notifier).state = query;
      ref.read(productSearchNotifierProvider.notifier).loadMoreSearchedProducts();
      GoRouter.of(context).push('/search');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _startSearch(),
            ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _startSearch,
        ),
      ],
    );
  }
}