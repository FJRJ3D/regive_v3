// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_format.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formatDateHash() => r'c87462ecc2ad6d5fb478f5246ce4f3bb16936f2a';

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

/// See also [formatDate].
@ProviderFor(formatDate)
const formatDateProvider = FormatDateFamily();

/// See also [formatDate].
class FormatDateFamily extends Family<String> {
  /// See also [formatDate].
  const FormatDateFamily();

  /// See also [formatDate].
  FormatDateProvider call(dynamic ref, DateTime dataTime) {
    return FormatDateProvider(ref, dataTime);
  }

  @override
  FormatDateProvider getProviderOverride(
    covariant FormatDateProvider provider,
  ) {
    return call(provider.ref, provider.dataTime);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formatDateProvider';
}

/// See also [formatDate].
class FormatDateProvider extends AutoDisposeProvider<String> {
  /// See also [formatDate].
  FormatDateProvider(dynamic ref, DateTime dataTime)
    : this._internal(
        (ref) => formatDate(ref as FormatDateRef, ref, dataTime),
        from: formatDateProvider,
        name: r'formatDateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$formatDateHash,
        dependencies: FormatDateFamily._dependencies,
        allTransitiveDependencies: FormatDateFamily._allTransitiveDependencies,
        ref: ref,
        dataTime: dataTime,
      );

  FormatDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ref,
    required this.dataTime,
  }) : super.internal();

  final dynamic ref;
  final DateTime dataTime;

  @override
  Override overrideWith(String Function(FormatDateRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: FormatDateProvider._internal(
        (ref) => create(ref as FormatDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ref: ref,
        dataTime: dataTime,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _FormatDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormatDateProvider &&
        other.ref == ref &&
        other.dataTime == dataTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ref.hashCode);
    hash = _SystemHash.combine(hash, dataTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormatDateRef on AutoDisposeProviderRef<String> {
  /// The parameter `ref` of this provider.
  dynamic get ref;

  /// The parameter `dataTime` of this provider.
  DateTime get dataTime;
}

class _FormatDateProviderElement extends AutoDisposeProviderElement<String>
    with FormatDateRef {
  _FormatDateProviderElement(super.provider);

  @override
  dynamic get ref => (origin as FormatDateProvider).ref;
  @override
  DateTime get dataTime => (origin as FormatDateProvider).dataTime;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
