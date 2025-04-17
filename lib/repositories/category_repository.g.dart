// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryRepositoryHash() =>
    r'212a462c12fe18c6286087a226824d813a892c5d';

/// See also [categoryRepository].
@ProviderFor(categoryRepository)
final categoryRepositoryProvider =
    AutoDisposeProvider<CategoryRepository>.internal(
      categoryRepository,
      name: r'categoryRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$categoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryRepositoryRef = AutoDisposeProviderRef<CategoryRepository>;
String _$fetchAllCategoriesHash() =>
    r'f4d34fc7e545165d091d5571554b321cb7b0ac29';

/// See also [fetchAllCategories].
@ProviderFor(fetchAllCategories)
final fetchAllCategoriesProvider =
    AutoDisposeFutureProvider<List<ProductCategory>>.internal(
      fetchAllCategories,
      name: r'fetchAllCategoriesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$fetchAllCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchAllCategoriesRef =
    AutoDisposeFutureProviderRef<List<ProductCategory>>;
String _$fetchCategoryByIdHash() => r'18873f3fd1491c1c6497240d32fc401a86f5ac8b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchCategoryById].
@ProviderFor(fetchCategoryById)
const fetchCategoryByIdProvider = FetchCategoryByIdFamily();

/// See also [fetchCategoryById].
class FetchCategoryByIdFamily extends Family<AsyncValue<ProductCategory>> {
  /// See also [fetchCategoryById].
  const FetchCategoryByIdFamily();

  /// See also [fetchCategoryById].
  FetchCategoryByIdProvider call(String categoryId) {
    return FetchCategoryByIdProvider(categoryId);
  }

  @override
  FetchCategoryByIdProvider getProviderOverride(
    covariant FetchCategoryByIdProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchCategoryByIdProvider';
}

/// See also [fetchCategoryById].
class FetchCategoryByIdProvider
    extends AutoDisposeFutureProvider<ProductCategory> {
  /// See also [fetchCategoryById].
  FetchCategoryByIdProvider(String categoryId)
    : this._internal(
        (ref) => fetchCategoryById(ref as FetchCategoryByIdRef, categoryId),
        from: fetchCategoryByIdProvider,
        name: r'fetchCategoryByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchCategoryByIdHash,
        dependencies: FetchCategoryByIdFamily._dependencies,
        allTransitiveDependencies:
            FetchCategoryByIdFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  FetchCategoryByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String categoryId;

  @override
  Override overrideWith(
    FutureOr<ProductCategory> Function(FetchCategoryByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchCategoryByIdProvider._internal(
        (ref) => create(ref as FetchCategoryByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProductCategory> createElement() {
    return _FetchCategoryByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCategoryByIdProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchCategoryByIdRef on AutoDisposeFutureProviderRef<ProductCategory> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _FetchCategoryByIdProviderElement
    extends AutoDisposeFutureProviderElement<ProductCategory>
    with FetchCategoryByIdRef {
  _FetchCategoryByIdProviderElement(super.provider);

  @override
  String get categoryId => (origin as FetchCategoryByIdProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
