// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthRepository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInWithEmailPasswordHash() =>
    r'5f7c8a27680502ab8ae9b45d86b48308cf808156';

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

/// See also [signInWithEmailPassword].
@ProviderFor(signInWithEmailPassword)
const signInWithEmailPasswordProvider = SignInWithEmailPasswordFamily();

/// See also [signInWithEmailPassword].
class SignInWithEmailPasswordFamily
    extends Family<AsyncValue<UserCredential?>> {
  /// See also [signInWithEmailPassword].
  const SignInWithEmailPasswordFamily();

  /// See also [signInWithEmailPassword].
  SignInWithEmailPasswordProvider call(String email, String password) {
    return SignInWithEmailPasswordProvider(email, password);
  }

  @override
  SignInWithEmailPasswordProvider getProviderOverride(
    covariant SignInWithEmailPasswordProvider provider,
  ) {
    return call(provider.email, provider.password);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'signInWithEmailPasswordProvider';
}

/// See also [signInWithEmailPassword].
class SignInWithEmailPasswordProvider
    extends AutoDisposeFutureProvider<UserCredential?> {
  /// See also [signInWithEmailPassword].
  SignInWithEmailPasswordProvider(String email, String password)
    : this._internal(
        (ref) => signInWithEmailPassword(
          ref as SignInWithEmailPasswordRef,
          email,
          password,
        ),
        from: signInWithEmailPasswordProvider,
        name: r'signInWithEmailPasswordProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$signInWithEmailPasswordHash,
        dependencies: SignInWithEmailPasswordFamily._dependencies,
        allTransitiveDependencies:
            SignInWithEmailPasswordFamily._allTransitiveDependencies,
        email: email,
        password: password,
      );

  SignInWithEmailPasswordProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
    required this.password,
  }) : super.internal();

  final String email;
  final String password;

  @override
  Override overrideWith(
    FutureOr<UserCredential?> Function(SignInWithEmailPasswordRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SignInWithEmailPasswordProvider._internal(
        (ref) => create(ref as SignInWithEmailPasswordRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
        password: password,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserCredential?> createElement() {
    return _SignInWithEmailPasswordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SignInWithEmailPasswordProvider &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SignInWithEmailPasswordRef
    on AutoDisposeFutureProviderRef<UserCredential?> {
  /// The parameter `email` of this provider.
  String get email;

  /// The parameter `password` of this provider.
  String get password;
}

class _SignInWithEmailPasswordProviderElement
    extends AutoDisposeFutureProviderElement<UserCredential?>
    with SignInWithEmailPasswordRef {
  _SignInWithEmailPasswordProviderElement(super.provider);

  @override
  String get email => (origin as SignInWithEmailPasswordProvider).email;
  @override
  String get password => (origin as SignInWithEmailPasswordProvider).password;
}

String _$registerWithEmailPasswordHash() =>
    r'7395500eb83aaa452131acbd621461a910f32035';

/// See also [registerWithEmailPassword].
@ProviderFor(registerWithEmailPassword)
const registerWithEmailPasswordProvider = RegisterWithEmailPasswordFamily();

/// See also [registerWithEmailPassword].
class RegisterWithEmailPasswordFamily
    extends Family<AsyncValue<UserCredential?>> {
  /// See also [registerWithEmailPassword].
  const RegisterWithEmailPasswordFamily();

  /// See also [registerWithEmailPassword].
  RegisterWithEmailPasswordProvider call({
    required String email,
    required String password,
    required String displayName,
  }) {
    return RegisterWithEmailPasswordProvider(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  @override
  RegisterWithEmailPasswordProvider getProviderOverride(
    covariant RegisterWithEmailPasswordProvider provider,
  ) {
    return call(
      email: provider.email,
      password: provider.password,
      displayName: provider.displayName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'registerWithEmailPasswordProvider';
}

/// See also [registerWithEmailPassword].
class RegisterWithEmailPasswordProvider
    extends AutoDisposeFutureProvider<UserCredential?> {
  /// See also [registerWithEmailPassword].
  RegisterWithEmailPasswordProvider({
    required String email,
    required String password,
    required String displayName,
  }) : this._internal(
         (ref) => registerWithEmailPassword(
           ref as RegisterWithEmailPasswordRef,
           email: email,
           password: password,
           displayName: displayName,
         ),
         from: registerWithEmailPasswordProvider,
         name: r'registerWithEmailPasswordProvider',
         debugGetCreateSourceHash:
             const bool.fromEnvironment('dart.vm.product')
                 ? null
                 : _$registerWithEmailPasswordHash,
         dependencies: RegisterWithEmailPasswordFamily._dependencies,
         allTransitiveDependencies:
             RegisterWithEmailPasswordFamily._allTransitiveDependencies,
         email: email,
         password: password,
         displayName: displayName,
       );

  RegisterWithEmailPasswordProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
    required this.password,
    required this.displayName,
  }) : super.internal();

  final String email;
  final String password;
  final String displayName;

  @override
  Override overrideWith(
    FutureOr<UserCredential?> Function(RegisterWithEmailPasswordRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterWithEmailPasswordProvider._internal(
        (ref) => create(ref as RegisterWithEmailPasswordRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
        password: password,
        displayName: displayName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserCredential?> createElement() {
    return _RegisterWithEmailPasswordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterWithEmailPasswordProvider &&
        other.email == email &&
        other.password == password &&
        other.displayName == displayName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);
    hash = _SystemHash.combine(hash, displayName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegisterWithEmailPasswordRef
    on AutoDisposeFutureProviderRef<UserCredential?> {
  /// The parameter `email` of this provider.
  String get email;

  /// The parameter `password` of this provider.
  String get password;

  /// The parameter `displayName` of this provider.
  String get displayName;
}

class _RegisterWithEmailPasswordProviderElement
    extends AutoDisposeFutureProviderElement<UserCredential?>
    with RegisterWithEmailPasswordRef {
  _RegisterWithEmailPasswordProviderElement(super.provider);

  @override
  String get email => (origin as RegisterWithEmailPasswordProvider).email;
  @override
  String get password => (origin as RegisterWithEmailPasswordProvider).password;
  @override
  String get displayName =>
      (origin as RegisterWithEmailPasswordProvider).displayName;
}

String _$signOutHash() => r'9d10a6fdeda07c242e7fe31b7b5d6b45633c5568';

/// See also [signOut].
@ProviderFor(signOut)
final signOutProvider = AutoDisposeFutureProvider<void>.internal(
  signOut,
  name: r'signOutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signOutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignOutRef = AutoDisposeFutureProviderRef<void>;
String _$getUserIdHash() => r'469c69f83869320a8d1cd7477ede0f9b5523a810';

/// See also [getUserId].
@ProviderFor(getUserId)
final getUserIdProvider = AutoDisposeFutureProvider<String>.internal(
  getUserId,
  name: r'getUserIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetUserIdRef = AutoDisposeFutureProviderRef<String>;
String _$getUserHash() => r'7af9caecf1f6d0df4ce74b30f8bf6e1bb0059949';

/// See also [getUser].
@ProviderFor(getUser)
final getUserProvider = AutoDisposeFutureProvider<User?>.internal(
  getUser,
  name: r'getUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetUserRef = AutoDisposeFutureProviderRef<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
