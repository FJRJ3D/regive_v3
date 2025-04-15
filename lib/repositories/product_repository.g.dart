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
String _$createProductWithCurrentUserHash() =>
    r'ce77ce16186c622116701ea5d0170f955c0ff773';

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

/// See also [createProductWithCurrentUser].
@ProviderFor(createProductWithCurrentUser)
const createProductWithCurrentUserProvider =
    CreateProductWithCurrentUserFamily();

/// See also [createProductWithCurrentUser].
class CreateProductWithCurrentUserFamily extends Family<AsyncValue<void>> {
  /// See also [createProductWithCurrentUser].
  const CreateProductWithCurrentUserFamily();

  /// See also [createProductWithCurrentUser].
  CreateProductWithCurrentUserProvider call({required Product productRequest}) {
    return CreateProductWithCurrentUserProvider(productRequest: productRequest);
  }

  @override
  CreateProductWithCurrentUserProvider getProviderOverride(
    covariant CreateProductWithCurrentUserProvider provider,
  ) {
    return call(productRequest: provider.productRequest);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createProductWithCurrentUserProvider';
}

/// See also [createProductWithCurrentUser].
class CreateProductWithCurrentUserProvider
    extends AutoDisposeFutureProvider<void> {
  /// See also [createProductWithCurrentUser].
  CreateProductWithCurrentUserProvider({required Product productRequest})
    : this._internal(
        (ref) => createProductWithCurrentUser(
          ref as CreateProductWithCurrentUserRef,
          productRequest: productRequest,
        ),
        from: createProductWithCurrentUserProvider,
        name: r'createProductWithCurrentUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$createProductWithCurrentUserHash,
        dependencies: CreateProductWithCurrentUserFamily._dependencies,
        allTransitiveDependencies:
            CreateProductWithCurrentUserFamily._allTransitiveDependencies,
        productRequest: productRequest,
      );

  CreateProductWithCurrentUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productRequest,
  }) : super.internal();

  final Product productRequest;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateProductWithCurrentUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateProductWithCurrentUserProvider._internal(
        (ref) => create(ref as CreateProductWithCurrentUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productRequest: productRequest,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateProductWithCurrentUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateProductWithCurrentUserProvider &&
        other.productRequest == productRequest;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productRequest.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateProductWithCurrentUserRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `productRequest` of this provider.
  Product get productRequest;
}

class _CreateProductWithCurrentUserProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with CreateProductWithCurrentUserRef {
  _CreateProductWithCurrentUserProviderElement(super.provider);

  @override
  Product get productRequest =>
      (origin as CreateProductWithCurrentUserProvider).productRequest;
}

String _$getAllUserProductsHash() =>
    r'c067cf64c146c0f4cb08da7bd1e8c905477c6954';

/// See also [getAllUserProducts].
@ProviderFor(getAllUserProducts)
final getAllUserProductsProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
      getAllUserProducts,
      name: r'getAllUserProductsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$getAllUserProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllUserProductsRef = AutoDisposeFutureProviderRef<List<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
