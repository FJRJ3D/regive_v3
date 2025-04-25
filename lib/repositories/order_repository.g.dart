// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'455bb658a7abfa87bbf895fc847223bbbb5a380b';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = AutoDisposeProvider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrderRepositoryRef = AutoDisposeProviderRef<OrderRepository>;
String _$createAnOrderHash() => r'ec1f4da2d6816e45a5b5a0f7ae92d18a9f7da7d4';

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

/// See also [createAnOrder].
@ProviderFor(createAnOrder)
const createAnOrderProvider = CreateAnOrderFamily();

/// See also [createAnOrder].
class CreateAnOrderFamily extends Family<AsyncValue<String>> {
  /// See also [createAnOrder].
  const CreateAnOrderFamily();

  /// See also [createAnOrder].
  CreateAnOrderProvider call(String userId, String productId, String reason) {
    return CreateAnOrderProvider(userId, productId, reason);
  }

  @override
  CreateAnOrderProvider getProviderOverride(
    covariant CreateAnOrderProvider provider,
  ) {
    return call(provider.userId, provider.productId, provider.reason);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createAnOrderProvider';
}

/// See also [createAnOrder].
class CreateAnOrderProvider extends AutoDisposeFutureProvider<String> {
  /// See also [createAnOrder].
  CreateAnOrderProvider(String userId, String productId, String reason)
    : this._internal(
        (ref) =>
            createAnOrder(ref as CreateAnOrderRef, userId, productId, reason),
        from: createAnOrderProvider,
        name: r'createAnOrderProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$createAnOrderHash,
        dependencies: CreateAnOrderFamily._dependencies,
        allTransitiveDependencies:
            CreateAnOrderFamily._allTransitiveDependencies,
        userId: userId,
        productId: productId,
        reason: reason,
      );

  CreateAnOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.productId,
    required this.reason,
  }) : super.internal();

  final String userId;
  final String productId;
  final String reason;

  @override
  Override overrideWith(
    FutureOr<String> Function(CreateAnOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateAnOrderProvider._internal(
        (ref) => create(ref as CreateAnOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        productId: productId,
        reason: reason,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _CreateAnOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateAnOrderProvider &&
        other.userId == userId &&
        other.productId == productId &&
        other.reason == reason;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, reason.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateAnOrderRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `productId` of this provider.
  String get productId;

  /// The parameter `reason` of this provider.
  String get reason;
}

class _CreateAnOrderProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with CreateAnOrderRef {
  _CreateAnOrderProviderElement(super.provider);

  @override
  String get userId => (origin as CreateAnOrderProvider).userId;
  @override
  String get productId => (origin as CreateAnOrderProvider).productId;
  @override
  String get reason => (origin as CreateAnOrderProvider).reason;
}

String _$fetchOrdersByUserIdHash() =>
    r'ee134bf204c685943a9de23ca1bf89a619783359';

/// See also [fetchOrdersByUserId].
@ProviderFor(fetchOrdersByUserId)
const fetchOrdersByUserIdProvider = FetchOrdersByUserIdFamily();

/// See also [fetchOrdersByUserId].
class FetchOrdersByUserIdFamily extends Family<AsyncValue<List<ProductOrder>>> {
  /// See also [fetchOrdersByUserId].
  const FetchOrdersByUserIdFamily();

  /// See also [fetchOrdersByUserId].
  FetchOrdersByUserIdProvider call(String userId) {
    return FetchOrdersByUserIdProvider(userId);
  }

  @override
  FetchOrdersByUserIdProvider getProviderOverride(
    covariant FetchOrdersByUserIdProvider provider,
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
  String? get name => r'fetchOrdersByUserIdProvider';
}

/// See also [fetchOrdersByUserId].
class FetchOrdersByUserIdProvider
    extends AutoDisposeFutureProvider<List<ProductOrder>> {
  /// See also [fetchOrdersByUserId].
  FetchOrdersByUserIdProvider(String userId)
    : this._internal(
        (ref) => fetchOrdersByUserId(ref as FetchOrdersByUserIdRef, userId),
        from: fetchOrdersByUserIdProvider,
        name: r'fetchOrdersByUserIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchOrdersByUserIdHash,
        dependencies: FetchOrdersByUserIdFamily._dependencies,
        allTransitiveDependencies:
            FetchOrdersByUserIdFamily._allTransitiveDependencies,
        userId: userId,
      );

  FetchOrdersByUserIdProvider._internal(
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
    FutureOr<List<ProductOrder>> Function(FetchOrdersByUserIdRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrdersByUserIdProvider._internal(
        (ref) => create(ref as FetchOrdersByUserIdRef),
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
  AutoDisposeFutureProviderElement<List<ProductOrder>> createElement() {
    return _FetchOrdersByUserIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrdersByUserIdProvider && other.userId == userId;
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
mixin FetchOrdersByUserIdRef
    on AutoDisposeFutureProviderRef<List<ProductOrder>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FetchOrdersByUserIdProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductOrder>>
    with FetchOrdersByUserIdRef {
  _FetchOrdersByUserIdProviderElement(super.provider);

  @override
  String get userId => (origin as FetchOrdersByUserIdProvider).userId;
}

String _$fetchOrdersByProductIdHash() =>
    r'61597a73265f2032ed56e2c4bef703874f41156a';

/// See also [fetchOrdersByProductId].
@ProviderFor(fetchOrdersByProductId)
const fetchOrdersByProductIdProvider = FetchOrdersByProductIdFamily();

/// See also [fetchOrdersByProductId].
class FetchOrdersByProductIdFamily
    extends Family<AsyncValue<List<ProductOrder>>> {
  /// See also [fetchOrdersByProductId].
  const FetchOrdersByProductIdFamily();

  /// See also [fetchOrdersByProductId].
  FetchOrdersByProductIdProvider call(String productId) {
    return FetchOrdersByProductIdProvider(productId);
  }

  @override
  FetchOrdersByProductIdProvider getProviderOverride(
    covariant FetchOrdersByProductIdProvider provider,
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
  String? get name => r'fetchOrdersByProductIdProvider';
}

/// See also [fetchOrdersByProductId].
class FetchOrdersByProductIdProvider
    extends AutoDisposeFutureProvider<List<ProductOrder>> {
  /// See also [fetchOrdersByProductId].
  FetchOrdersByProductIdProvider(String productId)
    : this._internal(
        (ref) =>
            fetchOrdersByProductId(ref as FetchOrdersByProductIdRef, productId),
        from: fetchOrdersByProductIdProvider,
        name: r'fetchOrdersByProductIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchOrdersByProductIdHash,
        dependencies: FetchOrdersByProductIdFamily._dependencies,
        allTransitiveDependencies:
            FetchOrdersByProductIdFamily._allTransitiveDependencies,
        productId: productId,
      );

  FetchOrdersByProductIdProvider._internal(
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
    FutureOr<List<ProductOrder>> Function(FetchOrdersByProductIdRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrdersByProductIdProvider._internal(
        (ref) => create(ref as FetchOrdersByProductIdRef),
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
  AutoDisposeFutureProviderElement<List<ProductOrder>> createElement() {
    return _FetchOrdersByProductIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrdersByProductIdProvider &&
        other.productId == productId;
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
mixin FetchOrdersByProductIdRef
    on AutoDisposeFutureProviderRef<List<ProductOrder>> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _FetchOrdersByProductIdProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductOrder>>
    with FetchOrdersByProductIdRef {
  _FetchOrdersByProductIdProviderElement(super.provider);

  @override
  String get productId => (origin as FetchOrdersByProductIdProvider).productId;
}

String _$deleteOrderByIdHash() => r'1695e62e3538add99fd9c6490a46c7ca11c8756c';

/// See also [deleteOrderById].
@ProviderFor(deleteOrderById)
const deleteOrderByIdProvider = DeleteOrderByIdFamily();

/// See also [deleteOrderById].
class DeleteOrderByIdFamily extends Family<AsyncValue<void>> {
  /// See also [deleteOrderById].
  const DeleteOrderByIdFamily();

  /// See also [deleteOrderById].
  DeleteOrderByIdProvider call(String orderId) {
    return DeleteOrderByIdProvider(orderId);
  }

  @override
  DeleteOrderByIdProvider getProviderOverride(
    covariant DeleteOrderByIdProvider provider,
  ) {
    return call(provider.orderId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteOrderByIdProvider';
}

/// See also [deleteOrderById].
class DeleteOrderByIdProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteOrderById].
  DeleteOrderByIdProvider(String orderId)
    : this._internal(
        (ref) => deleteOrderById(ref as DeleteOrderByIdRef, orderId),
        from: deleteOrderByIdProvider,
        name: r'deleteOrderByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$deleteOrderByIdHash,
        dependencies: DeleteOrderByIdFamily._dependencies,
        allTransitiveDependencies:
            DeleteOrderByIdFamily._allTransitiveDependencies,
        orderId: orderId,
      );

  DeleteOrderByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteOrderByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteOrderByIdProvider._internal(
        (ref) => create(ref as DeleteOrderByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteOrderByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteOrderByIdProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteOrderByIdRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _DeleteOrderByIdProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with DeleteOrderByIdRef {
  _DeleteOrderByIdProviderElement(super.provider);

  @override
  String get orderId => (origin as DeleteOrderByIdProvider).orderId;
}

String _$getOrderCountByProductHash() =>
    r'810a8e0b69a8bf64b9f1472e627fb50319df9154';

/// See also [getOrderCountByProduct].
@ProviderFor(getOrderCountByProduct)
const getOrderCountByProductProvider = GetOrderCountByProductFamily();

/// See also [getOrderCountByProduct].
class GetOrderCountByProductFamily extends Family<AsyncValue<int>> {
  /// See also [getOrderCountByProduct].
  const GetOrderCountByProductFamily();

  /// See also [getOrderCountByProduct].
  GetOrderCountByProductProvider call(String productId) {
    return GetOrderCountByProductProvider(productId);
  }

  @override
  GetOrderCountByProductProvider getProviderOverride(
    covariant GetOrderCountByProductProvider provider,
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
  String? get name => r'getOrderCountByProductProvider';
}

/// See also [getOrderCountByProduct].
class GetOrderCountByProductProvider extends AutoDisposeFutureProvider<int> {
  /// See also [getOrderCountByProduct].
  GetOrderCountByProductProvider(String productId)
    : this._internal(
        (ref) =>
            getOrderCountByProduct(ref as GetOrderCountByProductRef, productId),
        from: getOrderCountByProductProvider,
        name: r'getOrderCountByProductProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$getOrderCountByProductHash,
        dependencies: GetOrderCountByProductFamily._dependencies,
        allTransitiveDependencies:
            GetOrderCountByProductFamily._allTransitiveDependencies,
        productId: productId,
      );

  GetOrderCountByProductProvider._internal(
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
    FutureOr<int> Function(GetOrderCountByProductRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOrderCountByProductProvider._internal(
        (ref) => create(ref as GetOrderCountByProductRef),
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
  AutoDisposeFutureProviderElement<int> createElement() {
    return _GetOrderCountByProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOrderCountByProductProvider &&
        other.productId == productId;
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
mixin GetOrderCountByProductRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _GetOrderCountByProductProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with GetOrderCountByProductRef {
  _GetOrderCountByProductProviderElement(super.provider);

  @override
  String get productId => (origin as GetOrderCountByProductProvider).productId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
