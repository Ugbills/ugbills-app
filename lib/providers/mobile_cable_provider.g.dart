// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_cable_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMobileCableProvidersHash() =>
    r'79bb32e7eecddf232215a4b0b422274033e2daf3';

/// See also [fetchMobileCableProviders].
@ProviderFor(fetchMobileCableProviders)
final fetchMobileCableProvidersProvider =
    AutoDisposeFutureProvider<List<MobileCableProduct>?>.internal(
  fetchMobileCableProviders,
  name: r'fetchMobileCableProvidersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchMobileCableProvidersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchMobileCableProvidersRef
    = AutoDisposeFutureProviderRef<List<MobileCableProduct>?>;
String _$validateMobileCableSmartcardHash() =>
    r'33035c96cac6150c54d3438f2293285cd7abf624';

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

/// See also [validateMobileCableSmartcard].
@ProviderFor(validateMobileCableSmartcard)
const validateMobileCableSmartcardProvider =
    ValidateMobileCableSmartcardFamily();

/// See also [validateMobileCableSmartcard].
class ValidateMobileCableSmartcardFamily extends Family<AsyncValue<String?>> {
  /// See also [validateMobileCableSmartcard].
  const ValidateMobileCableSmartcardFamily();

  /// See also [validateMobileCableSmartcard].
  ValidateMobileCableSmartcardProvider call({
    required String productCode,
    required String smartcard,
  }) {
    return ValidateMobileCableSmartcardProvider(
      productCode: productCode,
      smartcard: smartcard,
    );
  }

  @override
  ValidateMobileCableSmartcardProvider getProviderOverride(
    covariant ValidateMobileCableSmartcardProvider provider,
  ) {
    return call(
      productCode: provider.productCode,
      smartcard: provider.smartcard,
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
  String? get name => r'validateMobileCableSmartcardProvider';
}

/// See also [validateMobileCableSmartcard].
class ValidateMobileCableSmartcardProvider
    extends AutoDisposeFutureProvider<String?> {
  /// See also [validateMobileCableSmartcard].
  ValidateMobileCableSmartcardProvider({
    required String productCode,
    required String smartcard,
  }) : this._internal(
          (ref) => validateMobileCableSmartcard(
            ref as ValidateMobileCableSmartcardRef,
            productCode: productCode,
            smartcard: smartcard,
          ),
          from: validateMobileCableSmartcardProvider,
          name: r'validateMobileCableSmartcardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$validateMobileCableSmartcardHash,
          dependencies: ValidateMobileCableSmartcardFamily._dependencies,
          allTransitiveDependencies:
              ValidateMobileCableSmartcardFamily._allTransitiveDependencies,
          productCode: productCode,
          smartcard: smartcard,
        );

  ValidateMobileCableSmartcardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productCode,
    required this.smartcard,
  }) : super.internal();

  final String productCode;
  final String smartcard;

  @override
  Override overrideWith(
    FutureOr<String?> Function(ValidateMobileCableSmartcardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValidateMobileCableSmartcardProvider._internal(
        (ref) => create(ref as ValidateMobileCableSmartcardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productCode: productCode,
        smartcard: smartcard,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _ValidateMobileCableSmartcardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValidateMobileCableSmartcardProvider &&
        other.productCode == productCode &&
        other.smartcard == smartcard;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productCode.hashCode);
    hash = _SystemHash.combine(hash, smartcard.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ValidateMobileCableSmartcardRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `productCode` of this provider.
  String get productCode;

  /// The parameter `smartcard` of this provider.
  String get smartcard;
}

class _ValidateMobileCableSmartcardProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with ValidateMobileCableSmartcardRef {
  _ValidateMobileCableSmartcardProviderElement(super.provider);

  @override
  String get productCode =>
      (origin as ValidateMobileCableSmartcardProvider).productCode;
  @override
  String get smartcard =>
      (origin as ValidateMobileCableSmartcardProvider).smartcard;
}

String _$purchaseMobileCableHash() =>
    r'432bc19fa8fa4ffd8ca3723bec770d88df17d756';

/// See also [purchaseMobileCable].
@ProviderFor(purchaseMobileCable)
const purchaseMobileCableProvider = PurchaseMobileCableFamily();

/// See also [purchaseMobileCable].
class PurchaseMobileCableFamily
    extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [purchaseMobileCable].
  const PurchaseMobileCableFamily();

  /// See also [purchaseMobileCable].
  PurchaseMobileCableProvider call({
    required String productCode,
    required String variationCode,
    required String smartcard,
    required String pin,
  }) {
    return PurchaseMobileCableProvider(
      productCode: productCode,
      variationCode: variationCode,
      smartcard: smartcard,
      pin: pin,
    );
  }

  @override
  PurchaseMobileCableProvider getProviderOverride(
    covariant PurchaseMobileCableProvider provider,
  ) {
    return call(
      productCode: provider.productCode,
      variationCode: provider.variationCode,
      smartcard: provider.smartcard,
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
  String? get name => r'purchaseMobileCableProvider';
}

/// See also [purchaseMobileCable].
class PurchaseMobileCableProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [purchaseMobileCable].
  PurchaseMobileCableProvider({
    required String productCode,
    required String variationCode,
    required String smartcard,
    required String pin,
  }) : this._internal(
          (ref) => purchaseMobileCable(
            ref as PurchaseMobileCableRef,
            productCode: productCode,
            variationCode: variationCode,
            smartcard: smartcard,
            pin: pin,
          ),
          from: purchaseMobileCableProvider,
          name: r'purchaseMobileCableProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchaseMobileCableHash,
          dependencies: PurchaseMobileCableFamily._dependencies,
          allTransitiveDependencies:
              PurchaseMobileCableFamily._allTransitiveDependencies,
          productCode: productCode,
          variationCode: variationCode,
          smartcard: smartcard,
          pin: pin,
        );

  PurchaseMobileCableProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productCode,
    required this.variationCode,
    required this.smartcard,
    required this.pin,
  }) : super.internal();

  final String productCode;
  final String variationCode;
  final String smartcard;
  final String pin;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(PurchaseMobileCableRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchaseMobileCableProvider._internal(
        (ref) => create(ref as PurchaseMobileCableRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productCode: productCode,
        variationCode: variationCode,
        smartcard: smartcard,
        pin: pin,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _PurchaseMobileCableProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseMobileCableProvider &&
        other.productCode == productCode &&
        other.variationCode == variationCode &&
        other.smartcard == smartcard &&
        other.pin == pin;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productCode.hashCode);
    hash = _SystemHash.combine(hash, variationCode.hashCode);
    hash = _SystemHash.combine(hash, smartcard.hashCode);
    hash = _SystemHash.combine(hash, pin.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PurchaseMobileCableRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `productCode` of this provider.
  String get productCode;

  /// The parameter `variationCode` of this provider.
  String get variationCode;

  /// The parameter `smartcard` of this provider.
  String get smartcard;

  /// The parameter `pin` of this provider.
  String get pin;
}

class _PurchaseMobileCableProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with PurchaseMobileCableRef {
  _PurchaseMobileCableProviderElement(super.provider);

  @override
  String get productCode => (origin as PurchaseMobileCableProvider).productCode;
  @override
  String get variationCode =>
      (origin as PurchaseMobileCableProvider).variationCode;
  @override
  String get smartcard => (origin as PurchaseMobileCableProvider).smartcard;
  @override
  String get pin => (origin as PurchaseMobileCableProvider).pin;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
