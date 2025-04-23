// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderServiceHash() => r'40ca273ea15d85f321e47f18b378ba224cd4dfc3';

/// See also [orderService].
@ProviderFor(orderService)
final orderServiceProvider = AutoDisposeProvider<OrderService>.internal(
  orderService,
  name: r'orderServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrderServiceRef = AutoDisposeProviderRef<OrderService>;
String _$fetchOrderWithProductHash() =>
    r'150c0fcf3d0c98aa5c7b35e85c463f2ce039b2f0';

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

/// See also [fetchOrderWithProduct].
@ProviderFor(fetchOrderWithProduct)
const fetchOrderWithProductProvider = FetchOrderWithProductFamily();

/// See also [fetchOrderWithProduct].
class FetchOrderWithProductFamily
    extends Family<AsyncValue<List<OrderWithProduct>>> {
  /// See also [fetchOrderWithProduct].
  const FetchOrderWithProductFamily();

  /// See also [fetchOrderWithProduct].
  FetchOrderWithProductProvider call(String userId) {
    return FetchOrderWithProductProvider(userId);
  }

  @override
  FetchOrderWithProductProvider getProviderOverride(
    covariant FetchOrderWithProductProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchOrderWithProductProvider';
}

/// See also [fetchOrderWithProduct].
class FetchOrderWithProductProvider
    extends AutoDisposeFutureProvider<List<OrderWithProduct>> {
  /// See also [fetchOrderWithProduct].
  FetchOrderWithProductProvider(String userId)
    : this._internal(
        (ref) => fetchOrderWithProduct(ref as FetchOrderWithProductRef, userId),
        from: fetchOrderWithProductProvider,
        name: r'fetchOrderWithProductProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchOrderWithProductHash,
        dependencies: FetchOrderWithProductFamily._dependencies,
        allTransitiveDependencies:
            FetchOrderWithProductFamily._allTransitiveDependencies,
        userId: userId,
      );

  FetchOrderWithProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<OrderWithProduct>> Function(FetchOrderWithProductRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrderWithProductProvider._internal(
        (ref) => create(ref as FetchOrderWithProductRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrderWithProduct>> createElement() {
    return _FetchOrderWithProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrderWithProductProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchOrderWithProductRef
    on AutoDisposeFutureProviderRef<List<OrderWithProduct>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FetchOrderWithProductProviderElement
    extends AutoDisposeFutureProviderElement<List<OrderWithProduct>>
    with FetchOrderWithProductRef {
  _FetchOrderWithProductProviderElement(super.provider);

  @override
  String get userId => (origin as FetchOrderWithProductProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
