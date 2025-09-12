// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$swapAirtimeHash() => r'9209d0efbe80aa87cdf03a90ad1df079c0082c52';

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

/// See also [swapAirtime].
@ProviderFor(swapAirtime)
const swapAirtimeProvider = SwapAirtimeFamily();

/// See also [swapAirtime].
class SwapAirtimeFamily extends Family<AsyncValue<SwapResultModel?>> {
  /// See also [swapAirtime].
  const SwapAirtimeFamily();

  /// See also [swapAirtime].
  SwapAirtimeProvider call({
    required String network,
    required dynamic amount,
    required String phoneNumber,
  }) {
    return SwapAirtimeProvider(
      network: network,
      amount: amount,
      phoneNumber: phoneNumber,
    );
  }

  @override
  SwapAirtimeProvider getProviderOverride(
    covariant SwapAirtimeProvider provider,
  ) {
    return call(
      network: provider.network,
      amount: provider.amount,
      phoneNumber: provider.phoneNumber,
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
  String? get name => r'swapAirtimeProvider';
}

/// See also [swapAirtime].
class SwapAirtimeProvider extends AutoDisposeFutureProvider<SwapResultModel?> {
  /// See also [swapAirtime].
  SwapAirtimeProvider({
    required String network,
    required dynamic amount,
    required String phoneNumber,
  }) : this._internal(
          (ref) => swapAirtime(
            ref as SwapAirtimeRef,
            network: network,
            amount: amount,
            phoneNumber: phoneNumber,
          ),
          from: swapAirtimeProvider,
          name: r'swapAirtimeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$swapAirtimeHash,
          dependencies: SwapAirtimeFamily._dependencies,
          allTransitiveDependencies:
              SwapAirtimeFamily._allTransitiveDependencies,
          network: network,
          amount: amount,
          phoneNumber: phoneNumber,
        );

  SwapAirtimeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.network,
    required this.amount,
    required this.phoneNumber,
  }) : super.internal();

  final String network;
  final dynamic amount;
  final String phoneNumber;

  @override
  Override overrideWith(
    FutureOr<SwapResultModel?> Function(SwapAirtimeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SwapAirtimeProvider._internal(
        (ref) => create(ref as SwapAirtimeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        network: network,
        amount: amount,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SwapResultModel?> createElement() {
    return _SwapAirtimeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SwapAirtimeProvider &&
        other.network == network &&
        other.amount == amount &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, network.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SwapAirtimeRef on AutoDisposeFutureProviderRef<SwapResultModel?> {
  /// The parameter `network` of this provider.
  String get network;

  /// The parameter `amount` of this provider.
  dynamic get amount;

  /// The parameter `phoneNumber` of this provider.
  String get phoneNumber;
}

class _SwapAirtimeProviderElement
    extends AutoDisposeFutureProviderElement<SwapResultModel?>
    with SwapAirtimeRef {
  _SwapAirtimeProviderElement(super.provider);

  @override
  String get network => (origin as SwapAirtimeProvider).network;
  @override
  dynamic get amount => (origin as SwapAirtimeProvider).amount;
  @override
  String get phoneNumber => (origin as SwapAirtimeProvider).phoneNumber;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
