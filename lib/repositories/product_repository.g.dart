// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRepositoryHash() => r'96624751ee8bb83b11ec4d01acd78e81743a1c37';

/// See also [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider =
    AutoDisposeProvider<ProductRepository>.internal(
      productRepository,
      name: r'productRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$productRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRepositoryRef = AutoDisposeProviderRef<ProductRepository>;
String _$fetchProductByIdHash() => r'6032a06ab7c400525a9d18b5246abf43c2649d9a';

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

/// See also [fetchProductById].
@ProviderFor(fetchProductById)
const fetchProductByIdProvider = FetchProductByIdFamily();

/// See also [fetchProductById].
class FetchProductByIdFamily extends Family<AsyncValue<Product>> {
  /// See also [fetchProductById].
  const FetchProductByIdFamily();

  /// See also [fetchProductById].
  FetchProductByIdProvider call(String productId) {
    return FetchProductByIdProvider(productId);
  }

  @override
  FetchProductByIdProvider getProviderOverride(
    covariant FetchProductByIdProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchProductByIdProvider';
}

/// See also [fetchProductById].
class FetchProductByIdProvider extends AutoDisposeFutureProvider<Product> {
  /// See also [fetchProductById].
  FetchProductByIdProvider(String productId)
    : this._internal(
        (ref) => fetchProductById(ref as FetchProductByIdRef, productId),
        from: fetchProductByIdProvider,
        name: r'fetchProductByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchProductByIdHash,
        dependencies: FetchProductByIdFamily._dependencies,
        allTransitiveDependencies:
            FetchProductByIdFamily._allTransitiveDependencies,
        productId: productId,
      );

  FetchProductByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    FutureOr<Product> Function(FetchProductByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProductByIdProvider._internal(
        (ref) => create(ref as FetchProductByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product> createElement() {
    return _FetchProductByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProductByIdProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchProductByIdRef on AutoDisposeFutureProviderRef<Product> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _FetchProductByIdProviderElement
    extends AutoDisposeFutureProviderElement<Product>
    with FetchProductByIdRef {
  _FetchProductByIdProviderElement(super.provider);

  @override
  String get productId => (origin as FetchProductByIdProvider).productId;
}

String _$fetchProductsBySearchHash() =>
    r'2e877b05e78732b8ee914d1d8b78ecb0446dfd14';

/// See also [fetchProductsBySearch].
@ProviderFor(fetchProductsBySearch)
const fetchProductsBySearchProvider = FetchProductsBySearchFamily();

/// See also [fetchProductsBySearch].
class FetchProductsBySearchFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [fetchProductsBySearch].
  const FetchProductsBySearchFamily();

  /// See also [fetchProductsBySearch].
  FetchProductsBySearchProvider call(String inputtedText) {
    return FetchProductsBySearchProvider(inputtedText);
  }

  @override
  FetchProductsBySearchProvider getProviderOverride(
    covariant FetchProductsBySearchProvider provider,
  ) {
    return call(provider.inputtedText);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchProductsBySearchProvider';
}

/// See also [fetchProductsBySearch].
class FetchProductsBySearchProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [fetchProductsBySearch].
  FetchProductsBySearchProvider(String inputtedText)
    : this._internal(
        (ref) => fetchProductsBySearch(
          ref as FetchProductsBySearchRef,
          inputtedText,
        ),
        from: fetchProductsBySearchProvider,
        name: r'fetchProductsBySearchProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchProductsBySearchHash,
        dependencies: FetchProductsBySearchFamily._dependencies,
        allTransitiveDependencies:
            FetchProductsBySearchFamily._allTransitiveDependencies,
        inputtedText: inputtedText,
      );

  FetchProductsBySearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inputtedText,
  }) : super.internal();

  final String inputtedText;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(FetchProductsBySearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProductsBySearchProvider._internal(
        (ref) => create(ref as FetchProductsBySearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inputtedText: inputtedText,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _FetchProductsBySearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProductsBySearchProvider &&
        other.inputtedText == inputtedText;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inputtedText.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchProductsBySearchRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `inputtedText` of this provider.
  String get inputtedText;
}

class _FetchProductsBySearchProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with FetchProductsBySearchRef {
  _FetchProductsBySearchProviderElement(super.provider);

  @override
  String get inputtedText =>
      (origin as FetchProductsBySearchProvider).inputtedText;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
