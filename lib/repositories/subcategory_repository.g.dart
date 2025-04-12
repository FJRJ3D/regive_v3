// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subcategoryRepositoryHash() =>
    r'0b26f0189cf96d4cc20d09bdda2c8cd47a164e76';

/// See also [subcategoryRepository].
@ProviderFor(subcategoryRepository)
final subcategoryRepositoryProvider =
    AutoDisposeProvider<SubcategoryRepository>.internal(
      subcategoryRepository,
      name: r'subcategoryRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$subcategoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubcategoryRepositoryRef =
    AutoDisposeProviderRef<SubcategoryRepository>;
String _$fetchSubcategoriesByCategoryIdHash() =>
    r'77aa9907b0704b0baeefcb0015d08f6569166f46';

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

/// See also [fetchSubcategoriesByCategoryId].
@ProviderFor(fetchSubcategoriesByCategoryId)
const fetchSubcategoriesByCategoryIdProvider =
    FetchSubcategoriesByCategoryIdFamily();

/// See also [fetchSubcategoriesByCategoryId].
class FetchSubcategoriesByCategoryIdFamily
    extends Family<AsyncValue<List<Subcategory>>> {
  /// See also [fetchSubcategoriesByCategoryId].
  const FetchSubcategoriesByCategoryIdFamily();

  /// See also [fetchSubcategoriesByCategoryId].
  FetchSubcategoriesByCategoryIdProvider call(String categoryId) {
    return FetchSubcategoriesByCategoryIdProvider(categoryId);
  }

  @override
  FetchSubcategoriesByCategoryIdProvider getProviderOverride(
    covariant FetchSubcategoriesByCategoryIdProvider provider,
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
  String? get name => r'fetchSubcategoriesByCategoryIdProvider';
}

/// See also [fetchSubcategoriesByCategoryId].
class FetchSubcategoriesByCategoryIdProvider
    extends AutoDisposeFutureProvider<List<Subcategory>> {
  /// See also [fetchSubcategoriesByCategoryId].
  FetchSubcategoriesByCategoryIdProvider(String categoryId)
    : this._internal(
        (ref) => fetchSubcategoriesByCategoryId(
          ref as FetchSubcategoriesByCategoryIdRef,
          categoryId,
        ),
        from: fetchSubcategoriesByCategoryIdProvider,
        name: r'fetchSubcategoriesByCategoryIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchSubcategoriesByCategoryIdHash,
        dependencies: FetchSubcategoriesByCategoryIdFamily._dependencies,
        allTransitiveDependencies:
            FetchSubcategoriesByCategoryIdFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  FetchSubcategoriesByCategoryIdProvider._internal(
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
    FutureOr<List<Subcategory>> Function(
      FetchSubcategoriesByCategoryIdRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchSubcategoriesByCategoryIdProvider._internal(
        (ref) => create(ref as FetchSubcategoriesByCategoryIdRef),
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
  AutoDisposeFutureProviderElement<List<Subcategory>> createElement() {
    return _FetchSubcategoriesByCategoryIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchSubcategoriesByCategoryIdProvider &&
        other.categoryId == categoryId;
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
mixin FetchSubcategoriesByCategoryIdRef
    on AutoDisposeFutureProviderRef<List<Subcategory>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _FetchSubcategoriesByCategoryIdProviderElement
    extends AutoDisposeFutureProviderElement<List<Subcategory>>
    with FetchSubcategoriesByCategoryIdRef {
  _FetchSubcategoriesByCategoryIdProviderElement(super.provider);

  @override
  String get categoryId =>
      (origin as FetchSubcategoriesByCategoryIdProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
