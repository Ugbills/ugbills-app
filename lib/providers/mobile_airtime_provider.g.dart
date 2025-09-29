// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_airtime_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMobileAirtimeProvidersHash() =>
    r'3b932482d5cdb53b9055c42c4d2065559b9d5e11';

/// See also [fetchMobileAirtimeProviders].
@ProviderFor(fetchMobileAirtimeProviders)
final fetchMobileAirtimeProvidersProvider =
    AutoDisposeFutureProvider<List<MobileAirtimeProduct>?>.internal(
  fetchMobileAirtimeProviders,
  name: r'fetchMobileAirtimeProvidersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchMobileAirtimeProvidersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchMobileAirtimeProvidersRef
    = AutoDisposeFutureProviderRef<List<MobileAirtimeProduct>?>;
String _$purchaseMobileAirtimeHash() =>
    r'4561e098bc62ab4d024236db0fdbbf643a6fb9f0';

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

/// See also [purchaseMobileAirtime].
@ProviderFor(purchaseMobileAirtime)
const purchaseMobileAirtimeProvider = PurchaseMobileAirtimeFamily();

/// See also [purchaseMobileAirtime].
class PurchaseMobileAirtimeFamily
    extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [purchaseMobileAirtime].
  const PurchaseMobileAirtimeFamily();

  /// See also [purchaseMobileAirtime].
  PurchaseMobileAirtimeProvider call({
    required String productCode,
    required String beneficiary,
    required double amount,
    required String pin,
  }) {
    return PurchaseMobileAirtimeProvider(
      productCode: productCode,
      beneficiary: beneficiary,
      amount: amount,
      pin: pin,
    );
  }

  @override
  PurchaseMobileAirtimeProvider getProviderOverride(
    covariant PurchaseMobileAirtimeProvider provider,
  ) {
    return call(
      productCode: provider.productCode,
      beneficiary: provider.beneficiary,
      amount: provider.amount,
      pin: provider.pin,
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
  String? get name => r'purchaseMobileAirtimeProvider';
}

/// See also [purchaseMobileAirtime].
class PurchaseMobileAirtimeProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [purchaseMobileAirtime].
  PurchaseMobileAirtimeProvider({
    required String productCode,
    required String beneficiary,
    required double amount,
    required String pin,
  }) : this._internal(
          (ref) => purchaseMobileAirtime(
            ref as PurchaseMobileAirtimeRef,
            productCode: productCode,
            beneficiary: beneficiary,
            amount: amount,
            pin: pin,
          ),
          from: purchaseMobileAirtimeProvider,
          name: r'purchaseMobileAirtimeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchaseMobileAirtimeHash,
          dependencies: PurchaseMobileAirtimeFamily._dependencies,
          allTransitiveDependencies:
              PurchaseMobileAirtimeFamily._allTransitiveDependencies,
          productCode: productCode,
          beneficiary: beneficiary,
          amount: amount,
          pin: pin,
        );

  PurchaseMobileAirtimeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productCode,
    required this.beneficiary,
    required this.amount,
    required this.pin,
  }) : super.internal();

  final String productCode;
  final String beneficiary;
  final double amount;
  final String pin;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(PurchaseMobileAirtimeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchaseMobileAirtimeProvider._internal(
        (ref) => create(ref as PurchaseMobileAirtimeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productCode: productCode,
        beneficiary: beneficiary,
        amount: amount,
        pin: pin,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _PurchaseMobileAirtimeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseMobileAirtimeProvider &&
        other.productCode == productCode &&
        other.beneficiary == beneficiary &&
        other.amount == amount &&
        other.pin == pin;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productCode.hashCode);
    hash = _SystemHash.combine(hash, beneficiary.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, pin.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PurchaseMobileAirtimeRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `productCode` of this provider.
  String get productCode;

  /// The parameter `beneficiary` of this provider.
  String get beneficiary;

  /// The parameter `amount` of this provider.
  double get amount;

  /// The parameter `pin` of this provider.
  String get pin;
}

class _PurchaseMobileAirtimeProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with PurchaseMobileAirtimeRef {
  _PurchaseMobileAirtimeProviderElement(super.provider);

  @override
  String get productCode =>
      (origin as PurchaseMobileAirtimeProvider).productCode;
  @override
  String get beneficiary =>
      (origin as PurchaseMobileAirtimeProvider).beneficiary;
  @override
  double get amount => (origin as PurchaseMobileAirtimeProvider).amount;
  @override
  String get pin => (origin as PurchaseMobileAirtimeProvider).pin;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
