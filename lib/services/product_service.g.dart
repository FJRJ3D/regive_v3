// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productServiceHash() => r'ac8068134746713ec7d5bf6233749368b993d16c';

/// See also [productService].
@ProviderFor(productService)
final productServiceProvider = AutoDisposeProvider<ProductService>.internal(
  productService,
  name: r'productServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductServiceRef = AutoDisposeProviderRef<ProductService>;
String _$fetchProductsWithUsersHash() =>
    r'8a36f5d04995b5442372608438813ea7dae54d64';

/// See also [fetchProductsWithUsers].
@ProviderFor(fetchProductsWithUsers)
final fetchProductsWithUsersProvider =
    AutoDisposeFutureProvider<List<ProductWithUser>>.internal(
      fetchProductsWithUsers,
      name: r'fetchProductsWithUsersProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$fetchProductsWithUsersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchProductsWithUsersRef =
    AutoDisposeFutureProviderRef<List<ProductWithUser>>;
String _$fetchProductWithUserBySearchHash() =>
    r'e7438d54c0658b830a704628818f582d105f3505';

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

/// See also [fetchProductWithUserBySearch].
@ProviderFor(fetchProductWithUserBySearch)
const fetchProductWithUserBySearchProvider =
    FetchProductWithUserBySearchFamily();

/// See also [fetchProductWithUserBySearch].
class FetchProductWithUserBySearchFamily
    extends Family<AsyncValue<List<ProductWithUser>>> {
  /// See also [fetchProductWithUserBySearch].
  const FetchProductWithUserBySearchFamily();

  /// See also [fetchProductWithUserBySearch].
  FetchProductWithUserBySearchProvider call(String inputtedText) {
    return FetchProductWithUserBySearchProvider(inputtedText);
  }

  @override
  FetchProductWithUserBySearchProvider getProviderOverride(
    covariant FetchProductWithUserBySearchProvider provider,
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
  String? get name => r'fetchProductWithUserBySearchProvider';
}

/// See also [fetchProductWithUserBySearch].
class FetchProductWithUserBySearchProvider
    extends AutoDisposeFutureProvider<List<ProductWithUser>> {
  /// See also [fetchProductWithUserBySearch].
  FetchProductWithUserBySearchProvider(String inputtedText)
    : this._internal(
        (ref) => fetchProductWithUserBySearch(
          ref as FetchProductWithUserBySearchRef,
          inputtedText,
        ),
        from: fetchProductWithUserBySearchProvider,
        name: r'fetchProductWithUserBySearchProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchProductWithUserBySearchHash,
        dependencies: FetchProductWithUserBySearchFamily._dependencies,
        allTransitiveDependencies:
            FetchProductWithUserBySearchFamily._allTransitiveDependencies,
        inputtedText: inputtedText,
      );

  FetchProductWithUserBySearchProvider._internal(
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
    FutureOr<List<ProductWithUser>> Function(
      FetchProductWithUserBySearchRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProductWithUserBySearchProvider._internal(
        (ref) => create(ref as FetchProductWithUserBySearchRef),
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
  AutoDisposeFutureProviderElement<List<ProductWithUser>> createElement() {
    return _FetchProductWithUserBySearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProductWithUserBySearchProvider &&
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
mixin FetchProductWithUserBySearchRef
    on AutoDisposeFutureProviderRef<List<ProductWithUser>> {
  /// The parameter `inputtedText` of this provider.
  String get inputtedText;
}

class _FetchProductWithUserBySearchProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductWithUser>>
    with FetchProductWithUserBySearchRef {
  _FetchProductWithUserBySearchProviderElement(super.provider);

  @override
  String get inputtedText =>
      (origin as FetchProductWithUserBySearchProvider).inputtedText;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
