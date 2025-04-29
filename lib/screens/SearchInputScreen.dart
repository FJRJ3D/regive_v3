import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/components/CategorySelectorModal.dart';
import 'package:regive_v3/models/ProductCategory.dart';
import 'package:regive_v3/models/Subcategory.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/category_repository.dart';
import 'package:regive_v3/repositories/subcategory_repository.dart';

class SearchInputScreen extends ConsumerStatefulWidget {
  const SearchInputScreen({super.key});

  @override
  ConsumerState<SearchInputScreen> createState() => _SearchInputScreenState();
}

class _SearchInputScreenState extends ConsumerState<SearchInputScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focus = FocusNode();

  String? _selectedCategoryId;
  String? _selectedSubcategoryId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focus);
    });
  }

  void _onSearch(String q) {
    final query = q.trim();
    if (query.isEmpty) return;
    ref.read(inputtedTextToSearchProvider.notifier).state = query;
    GoRouter.of(context).go('/search');
  }

  void _openCategoryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CategorySelectorModal(),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => GoRouter.of(context).pop()),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                focusNode: _focus,
                decoration: const InputDecoration(
                  hintText: 'Input what you search',
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: _onSearch,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _openCategoryModal,
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Write text what you search')),
    );
  }
}
