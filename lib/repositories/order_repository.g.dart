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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
