// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_electricity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMobileElectricityProvidersHash() =>
    r'd6719cd1c40844d1ec30557d360a5fe520c1500a';

/// See also [fetchMobileElectricityProviders].
@ProviderFor(fetchMobileElectricityProviders)
final fetchMobileElectricityProvidersProvider =
    AutoDisposeFutureProvider<List<MobileElectricityProduct>?>.internal(
  fetchMobileElectricityProviders,
  name: r'fetchMobileElectricityProvidersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchMobileElectricityProvidersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchMobileElectricityProvidersRef
    = AutoDisposeFutureProviderRef<List<MobileElectricityProduct>?>;
String _$validateMobileElectricityMeterHash() =>
    r'3d7c90da36674bd41b7f71ead7a5424838bf0468';

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

/// See also [validateMobileElectricityMeter].
@ProviderFor(validateMobileElectricityMeter)
const validateMobileElectricityMeterProvider =
    ValidateMobileElectricityMeterFamily();

/// See also [validateMobileElectricityMeter].
class ValidateMobileElectricityMeterFamily extends Family<AsyncValue<String?>> {
  /// See also [validateMobileElectricityMeter].
  const ValidateMobileElectricityMeterFamily();

  /// See also [validateMobileElectricityMeter].
  ValidateMobileElectricityMeterProvider call({
    required String productCode,
    required String meterNumber,
    required String meterType,
  }) {
    return ValidateMobileElectricityMeterProvider(
      productCode: productCode,
      meterNumber: meterNumber,
      meterType: meterType,
    );
  }

  @override
  ValidateMobileElectricityMeterProvider getProviderOverride(
    covariant ValidateMobileElectricityMeterProvider provider,
  ) {
    return call(
      productCode: provider.productCode,
      meterNumber: provider.meterNumber,
      meterType: provider.meterType,
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
  String? get name => r'validateMobileElectricityMeterProvider';
}

/// See also [validateMobileElectricityMeter].
class ValidateMobileElectricityMeterProvider
    extends AutoDisposeFutureProvider<String?> {
  /// See also [validateMobileElectricityMeter].
  ValidateMobileElectricityMeterProvider({
    required String productCode,
    required String meterNumber,
    required String meterType,
  }) : this._internal(
          (ref) => validateMobileElectricityMeter(
            ref as ValidateMobileElectricityMeterRef,
            productCode: productCode,
            meterNumber: meterNumber,
            meterType: meterType,
          ),
          from: validateMobileElectricityMeterProvider,
          name: r'validateMobileElectricityMeterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$validateMobileElectricityMeterHash,
          dependencies: ValidateMobileElectricityMeterFamily._dependencies,
          allTransitiveDependencies:
              ValidateMobileElectricityMeterFamily._allTransitiveDependencies,
          productCode: productCode,
          meterNumber: meterNumber,
          meterType: meterType,
        );

  ValidateMobileElectricityMeterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productCode,
    required this.meterNumber,
    required this.meterType,
  }) : super.internal();

  final String productCode;
  final String meterNumber;
  final String meterType;

  @override
  Override overrideWith(
    FutureOr<String?> Function(ValidateMobileElectricityMeterRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValidateMobileElectricityMeterProvider._internal(
        (ref) => create(ref as ValidateMobileElectricityMeterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productCode: productCode,
        meterNumber: meterNumber,
        meterType: meterType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _ValidateMobileElectricityMeterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValidateMobileElectricityMeterProvider &&
        other.productCode == productCode &&
        other.meterNumber == meterNumber &&
        other.meterType == meterType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productCode.hashCode);
    hash = _SystemHash.combine(hash, meterNumber.hashCode);
    hash = _SystemHash.combine(hash, meterType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ValidateMobileElectricityMeterRef
    on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `productCode` of this provider.
  String get productCode;

  /// The parameter `meterNumber` of this provider.
  String get meterNumber;

  /// The parameter `meterType` of this provider.
  String get meterType;
}

class _ValidateMobileElectricityMeterProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with ValidateMobileElectricityMeterRef {
  _ValidateMobileElectricityMeterProviderElement(super.provider);

  @override
  String get productCode =>
      (origin as ValidateMobileElectricityMeterProvider).productCode;
  @override
  String get meterNumber =>
      (origin as ValidateMobileElectricityMeterProvider).meterNumber;
  @override
  String get meterType =>
      (origin as ValidateMobileElectricityMeterProvider).meterType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
