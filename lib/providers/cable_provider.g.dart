// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cable_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchTvProvidersHash() => r'88c3025d9e484d0b8633ea37fc731c9e05f6fe18';

/// See also [fetchTvProviders].
@ProviderFor(fetchTvProviders)
final fetchTvProvidersProvider = FutureProvider<List<dynamic>?>.internal(
  fetchTvProviders,
  name: r'fetchTvProvidersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchTvProvidersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchTvProvidersRef = FutureProviderRef<List<dynamic>?>;
String _$fetchTvPackagesHash() => r'30be0557e62f63760db9fc6cd6f43c6c77a3d592';

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

/// See also [fetchTvPackages].
@ProviderFor(fetchTvPackages)
const fetchTvPackagesProvider = FetchTvPackagesFamily();

/// See also [fetchTvPackages].
class FetchTvPackagesFamily extends Family<AsyncValue<CablePlans?>> {
  /// See also [fetchTvPackages].
  const FetchTvPackagesFamily();

  /// See also [fetchTvPackages].
  FetchTvPackagesProvider call({
    required String cableName,
  }) {
    return FetchTvPackagesProvider(
      cableName: cableName,
    );
  }

  @override
  FetchTvPackagesProvider getProviderOverride(
    covariant FetchTvPackagesProvider provider,
  ) {
    return call(
      cableName: provider.cableName,
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
  String? get name => r'fetchTvPackagesProvider';
}

/// See also [fetchTvPackages].
class FetchTvPackagesProvider extends FutureProvider<CablePlans?> {
  /// See also [fetchTvPackages].
  FetchTvPackagesProvider({
    required String cableName,
  }) : this._internal(
          (ref) => fetchTvPackages(
            ref as FetchTvPackagesRef,
            cableName: cableName,
          ),
          from: fetchTvPackagesProvider,
          name: r'fetchTvPackagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchTvPackagesHash,
          dependencies: FetchTvPackagesFamily._dependencies,
          allTransitiveDependencies:
              FetchTvPackagesFamily._allTransitiveDependencies,
          cableName: cableName,
        );

  FetchTvPackagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cableName,
  }) : super.internal();

  final String cableName;

  @override
  Override overrideWith(
    FutureOr<CablePlans?> Function(FetchTvPackagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchTvPackagesProvider._internal(
        (ref) => create(ref as FetchTvPackagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cableName: cableName,
      ),
    );
  }

  @override
  FutureProviderElement<CablePlans?> createElement() {
    return _FetchTvPackagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchTvPackagesProvider && other.cableName == cableName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cableName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchTvPackagesRef on FutureProviderRef<CablePlans?> {
  /// The parameter `cableName` of this provider.
  String get cableName;
}

class _FetchTvPackagesProviderElement extends FutureProviderElement<CablePlans?>
    with FetchTvPackagesRef {
  _FetchTvPackagesProviderElement(super.provider);

  @override
  String get cableName => (origin as FetchTvPackagesProvider).cableName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
