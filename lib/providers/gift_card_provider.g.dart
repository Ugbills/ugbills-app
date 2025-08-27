// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$giftCardCountriesHash() => r'678a071ba6d3d635adb59f8470bac280fc97a1f1';

/// See also [giftCardCountries].
@ProviderFor(giftCardCountries)
final giftCardCountriesProvider =
    FutureProvider<GiftCardCountryModel?>.internal(
  giftCardCountries,
  name: r'giftCardCountriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$giftCardCountriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GiftCardCountriesRef = FutureProviderRef<GiftCardCountryModel?>;
String _$giftCardsHash() => r'593642f72022f71c12079afa26cfd0e06e951a20';

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

/// See also [giftCards].
@ProviderFor(giftCards)
const giftCardsProvider = GiftCardsFamily();

/// See also [giftCards].
class GiftCardsFamily extends Family<AsyncValue<dynamic>> {
  /// See also [giftCards].
  const GiftCardsFamily();

  /// See also [giftCards].
  GiftCardsProvider call({
    required String countryCode,
    int limit = 100,
    int page = 1,
  }) {
    return GiftCardsProvider(
      countryCode: countryCode,
      limit: limit,
      page: page,
    );
  }

  @override
  GiftCardsProvider getProviderOverride(
    covariant GiftCardsProvider provider,
  ) {
    return call(
      countryCode: provider.countryCode,
      limit: provider.limit,
      page: provider.page,
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
  String? get name => r'giftCardsProvider';
}

/// See also [giftCards].
class GiftCardsProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [giftCards].
  GiftCardsProvider({
    required String countryCode,
    int limit = 100,
    int page = 1,
  }) : this._internal(
          (ref) => giftCards(
            ref as GiftCardsRef,
            countryCode: countryCode,
            limit: limit,
            page: page,
          ),
          from: giftCardsProvider,
          name: r'giftCardsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$giftCardsHash,
          dependencies: GiftCardsFamily._dependencies,
          allTransitiveDependencies: GiftCardsFamily._allTransitiveDependencies,
          countryCode: countryCode,
          limit: limit,
          page: page,
        );

  GiftCardsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.countryCode,
    required this.limit,
    required this.page,
  }) : super.internal();

  final String countryCode;
  final int limit;
  final int page;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(GiftCardsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GiftCardsProvider._internal(
        (ref) => create(ref as GiftCardsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        countryCode: countryCode,
        limit: limit,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _GiftCardsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GiftCardsProvider &&
        other.countryCode == countryCode &&
        other.limit == limit &&
        other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, countryCode.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GiftCardsRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `countryCode` of this provider.
  String get countryCode;

  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `page` of this provider.
  int get page;
}

class _GiftCardsProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with GiftCardsRef {
  _GiftCardsProviderElement(super.provider);

  @override
  String get countryCode => (origin as GiftCardsProvider).countryCode;
  @override
  int get limit => (origin as GiftCardsProvider).limit;
  @override
  int get page => (origin as GiftCardsProvider).page;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
