// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getNetworksHash() => r'ad3d01737061deb8a051ab6d89b672b9cd97d49f';

/// See also [getNetworks].
@ProviderFor(getNetworks)
final getNetworksProvider = FutureProvider<NetworksModel?>.internal(
  getNetworks,
  name: r'getNetworksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getNetworksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetNetworksRef = FutureProviderRef<NetworksModel?>;
String _$getDataPlansHash() => r'b624e94787262c04e9e5808e3e44906083497206';

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

/// See also [getDataPlans].
@ProviderFor(getDataPlans)
const getDataPlansProvider = GetDataPlansFamily();

/// See also [getDataPlans].
class GetDataPlansFamily extends Family<AsyncValue<DataPlansModel?>> {
  /// See also [getDataPlans].
  const GetDataPlansFamily();

  /// See also [getDataPlans].
  GetDataPlansProvider call({
    required String networkId,
  }) {
    return GetDataPlansProvider(
      networkId: networkId,
    );
  }

  @override
  GetDataPlansProvider getProviderOverride(
    covariant GetDataPlansProvider provider,
  ) {
    return call(
      networkId: provider.networkId,
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
  String? get name => r'getDataPlansProvider';
}

/// See also [getDataPlans].
class GetDataPlansProvider extends FutureProvider<DataPlansModel?> {
  /// See also [getDataPlans].
  GetDataPlansProvider({
    required String networkId,
  }) : this._internal(
          (ref) => getDataPlans(
            ref as GetDataPlansRef,
            networkId: networkId,
          ),
          from: getDataPlansProvider,
          name: r'getDataPlansProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDataPlansHash,
          dependencies: GetDataPlansFamily._dependencies,
          allTransitiveDependencies:
              GetDataPlansFamily._allTransitiveDependencies,
          networkId: networkId,
        );

  GetDataPlansProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.networkId,
  }) : super.internal();

  final String networkId;

  @override
  Override overrideWith(
    FutureOr<DataPlansModel?> Function(GetDataPlansRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDataPlansProvider._internal(
        (ref) => create(ref as GetDataPlansRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        networkId: networkId,
      ),
    );
  }

  @override
  FutureProviderElement<DataPlansModel?> createElement() {
    return _GetDataPlansProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDataPlansProvider && other.networkId == networkId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, networkId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDataPlansRef on FutureProviderRef<DataPlansModel?> {
  /// The parameter `networkId` of this provider.
  String get networkId;
}

class _GetDataPlansProviderElement
    extends FutureProviderElement<DataPlansModel?> with GetDataPlansRef {
  _GetDataPlansProviderElement(super.provider);

  @override
  String get networkId => (origin as GetDataPlansProvider).networkId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
