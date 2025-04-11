// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDetailsRepositoryHash() =>
    r'2dbce4061f14aca4f7e598f51d4feb750768b81b';

/// See also [userDetailsRepository].
@ProviderFor(userDetailsRepository)
final userDetailsRepositoryProvider =
    AutoDisposeProvider<UserDetailsRepository>.internal(
      userDetailsRepository,
      name: r'userDetailsRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userDetailsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserDetailsRepositoryRef =
    AutoDisposeProviderRef<UserDetailsRepository>;
String _$fetchUserDetailsByIdHash() =>
    r'ad2bb62bc39455fb9622cc3fa49d7d30956c8e03';

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

/// See also [fetchUserDetailsById].
@ProviderFor(fetchUserDetailsById)
const fetchUserDetailsByIdProvider = FetchUserDetailsByIdFamily();

/// See also [fetchUserDetailsById].
class FetchUserDetailsByIdFamily extends Family<AsyncValue<UserDetails>> {
  /// See also [fetchUserDetailsById].
  const FetchUserDetailsByIdFamily();

  /// See also [fetchUserDetailsById].
  FetchUserDetailsByIdProvider call(String userDetailsId) {
    return FetchUserDetailsByIdProvider(userDetailsId);
  }

  @override
  FetchUserDetailsByIdProvider getProviderOverride(
    covariant FetchUserDetailsByIdProvider provider,
  ) {
    return call(provider.userDetailsId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchUserDetailsByIdProvider';
}

/// See also [fetchUserDetailsById].
class FetchUserDetailsByIdProvider
    extends AutoDisposeFutureProvider<UserDetails> {
  /// See also [fetchUserDetailsById].
  FetchUserDetailsByIdProvider(String userDetailsId)
    : this._internal(
        (ref) =>
            fetchUserDetailsById(ref as FetchUserDetailsByIdRef, userDetailsId),
        from: fetchUserDetailsByIdProvider,
        name: r'fetchUserDetailsByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchUserDetailsByIdHash,
        dependencies: FetchUserDetailsByIdFamily._dependencies,
        allTransitiveDependencies:
            FetchUserDetailsByIdFamily._allTransitiveDependencies,
        userDetailsId: userDetailsId,
      );

  FetchUserDetailsByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userDetailsId,
  }) : super.internal();

  final String userDetailsId;

  @override
  Override overrideWith(
    FutureOr<UserDetails> Function(FetchUserDetailsByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUserDetailsByIdProvider._internal(
        (ref) => create(ref as FetchUserDetailsByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userDetailsId: userDetailsId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserDetails> createElement() {
    return _FetchUserDetailsByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUserDetailsByIdProvider &&
        other.userDetailsId == userDetailsId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userDetailsId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchUserDetailsByIdRef on AutoDisposeFutureProviderRef<UserDetails> {
  /// The parameter `userDetailsId` of this provider.
  String get userDetailsId;
}

class _FetchUserDetailsByIdProviderElement
    extends AutoDisposeFutureProviderElement<UserDetails>
    with FetchUserDetailsByIdRef {
  _FetchUserDetailsByIdProviderElement(super.provider);

  @override
  String get userDetailsId =>
      (origin as FetchUserDetailsByIdProvider).userDetailsId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
