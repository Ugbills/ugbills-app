// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_databundle_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$purchaseMobileDataHash() =>
    r'76340ff46d1ee151ff1e921f61273380b303b893';

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

/// See also [purchaseMobileData].
@ProviderFor(purchaseMobileData)
const purchaseMobileDataProvider = PurchaseMobileDataFamily();

/// See also [purchaseMobileData].
class PurchaseMobileDataFamily
    extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [purchaseMobileData].
  const PurchaseMobileDataFamily();

  /// See also [purchaseMobileData].
  PurchaseMobileDataProvider call({
    required String productCode,
    required String variationCode,
    required String beneficiary,
    required String pin,
  }) {
    return PurchaseMobileDataProvider(
      productCode: productCode,
      variationCode: variationCode,
      beneficiary: beneficiary,
      pin: pin,
    );
  }

  @override
  PurchaseMobileDataProvider getProviderOverride(
    covariant PurchaseMobileDataProvider provider,
  ) {
    return call(
      productCode: provider.productCode,
      variationCode: provider.variationCode,
      beneficiary: provider.beneficiary,
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
  String? get name => r'purchaseMobileDataProvider';
}

/// See also [purchaseMobileData].
class PurchaseMobileDataProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [purchaseMobileData].
  PurchaseMobileDataProvider({
    required String productCode,
    required String variationCode,
    required String beneficiary,
    required String pin,
  }) : this._internal(
          (ref) => purchaseMobileData(
            ref as PurchaseMobileDataRef,
            productCode: productCode,
            variationCode: variationCode,
            beneficiary: beneficiary,
            pin: pin,
          ),
          from: purchaseMobileDataProvider,
          name: r'purchaseMobileDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchaseMobileDataHash,
          dependencies: PurchaseMobileDataFamily._dependencies,
          allTransitiveDependencies:
              PurchaseMobileDataFamily._allTransitiveDependencies,
          productCode: productCode,
          variationCode: variationCode,
          beneficiary: beneficiary,
          pin: pin,
        );

  PurchaseMobileDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productCode,
    required this.variationCode,
    required this.beneficiary,
    required this.pin,
  }) : super.internal();

  final String productCode;
  final String variationCode;
  final String beneficiary;
  final String pin;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(PurchaseMobileDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchaseMobileDataProvider._internal(
        (ref) => create(ref as PurchaseMobileDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productCode: productCode,
        variationCode: variationCode,
        beneficiary: beneficiary,
        pin: pin,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _PurchaseMobileDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseMobileDataProvider &&
        other.productCode == productCode &&
        other.variationCode == variationCode &&
        other.beneficiary == beneficiary &&
        other.pin == pin;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productCode.hashCode);
    hash = _SystemHash.combine(hash, variationCode.hashCode);
    hash = _SystemHash.combine(hash, beneficiary.hashCode);
    hash = _SystemHash.combine(hash, pin.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PurchaseMobileDataRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `productCode` of this provider.
  String get productCode;

  /// The parameter `variationCode` of this provider.
  String get variationCode;

  /// The parameter `beneficiary` of this provider.
  String get beneficiary;

  /// The parameter `pin` of this provider.
  String get pin;
}

class _PurchaseMobileDataProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with PurchaseMobileDataRef {
  _PurchaseMobileDataProviderElement(super.provider);

  @override
  String get productCode => (origin as PurchaseMobileDataProvider).productCode;
  @override
  String get variationCode =>
      (origin as PurchaseMobileDataProvider).variationCode;
  @override
  String get beneficiary => (origin as PurchaseMobileDataProvider).beneficiary;
  @override
  String get pin => (origin as PurchaseMobileDataProvider).pin;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
