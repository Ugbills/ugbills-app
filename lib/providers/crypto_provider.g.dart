// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchCoinListHash() => r'184791609e79913cc3cab2cdfa58d608c52a9ce8';

/// See also [fetchCoinList].
@ProviderFor(fetchCoinList)
final fetchCoinListProvider = FutureProvider<CryptoListModel?>.internal(
  fetchCoinList,
  name: r'fetchCoinListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchCoinListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchCoinListRef = FutureProviderRef<CryptoListModel?>;
String _$fetchCryptoBuyQuoteHash() =>
    r'66393d5bdb6f98375873e38625b2c46c80473dc7';

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

/// See also [fetchCryptoBuyQuote].
@ProviderFor(fetchCryptoBuyQuote)
const fetchCryptoBuyQuoteProvider = FetchCryptoBuyQuoteFamily();

/// See also [fetchCryptoBuyQuote].
class FetchCryptoBuyQuoteFamily
    extends Family<AsyncValue<CryptoBuyQuoteModel?>> {
  /// See also [fetchCryptoBuyQuote].
  const FetchCryptoBuyQuoteFamily();

  /// See also [fetchCryptoBuyQuote].
  FetchCryptoBuyQuoteProvider call({
    required String currency,
    required double amount,
  }) {
    return FetchCryptoBuyQuoteProvider(
      currency: currency,
      amount: amount,
    );
  }

  @override
  FetchCryptoBuyQuoteProvider getProviderOverride(
    covariant FetchCryptoBuyQuoteProvider provider,
  ) {
    return call(
      currency: provider.currency,
      amount: provider.amount,
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
  String? get name => r'fetchCryptoBuyQuoteProvider';
}

/// See also [fetchCryptoBuyQuote].
class FetchCryptoBuyQuoteProvider
    extends AutoDisposeFutureProvider<CryptoBuyQuoteModel?> {
  /// See also [fetchCryptoBuyQuote].
  FetchCryptoBuyQuoteProvider({
    required String currency,
    required double amount,
  }) : this._internal(
          (ref) => fetchCryptoBuyQuote(
            ref as FetchCryptoBuyQuoteRef,
            currency: currency,
            amount: amount,
          ),
          from: fetchCryptoBuyQuoteProvider,
          name: r'fetchCryptoBuyQuoteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchCryptoBuyQuoteHash,
          dependencies: FetchCryptoBuyQuoteFamily._dependencies,
          allTransitiveDependencies:
              FetchCryptoBuyQuoteFamily._allTransitiveDependencies,
          currency: currency,
          amount: amount,
        );

  FetchCryptoBuyQuoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currency,
    required this.amount,
  }) : super.internal();

  final String currency;
  final double amount;

  @override
  Override overrideWith(
    FutureOr<CryptoBuyQuoteModel?> Function(FetchCryptoBuyQuoteRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchCryptoBuyQuoteProvider._internal(
        (ref) => create(ref as FetchCryptoBuyQuoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currency: currency,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CryptoBuyQuoteModel?> createElement() {
    return _FetchCryptoBuyQuoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCryptoBuyQuoteProvider &&
        other.currency == currency &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchCryptoBuyQuoteRef
    on AutoDisposeFutureProviderRef<CryptoBuyQuoteModel?> {
  /// The parameter `currency` of this provider.
  String get currency;

  /// The parameter `amount` of this provider.
  double get amount;
}

class _FetchCryptoBuyQuoteProviderElement
    extends AutoDisposeFutureProviderElement<CryptoBuyQuoteModel?>
    with FetchCryptoBuyQuoteRef {
  _FetchCryptoBuyQuoteProviderElement(super.provider);

  @override
  String get currency => (origin as FetchCryptoBuyQuoteProvider).currency;
  @override
  double get amount => (origin as FetchCryptoBuyQuoteProvider).amount;
}

String _$fetchCryptoSellQuoteHash() =>
    r'c832d4926334a3fe29392d19248a7a236b5d873d';

/// See also [fetchCryptoSellQuote].
@ProviderFor(fetchCryptoSellQuote)
const fetchCryptoSellQuoteProvider = FetchCryptoSellQuoteFamily();

/// See also [fetchCryptoSellQuote].
class FetchCryptoSellQuoteFamily
    extends Family<AsyncValue<CryptoSellQuoteModel?>> {
  /// See also [fetchCryptoSellQuote].
  const FetchCryptoSellQuoteFamily();

  /// See also [fetchCryptoSellQuote].
  FetchCryptoSellQuoteProvider call({
    required String currency,
    required String network,
    required double amount,
  }) {
    return FetchCryptoSellQuoteProvider(
      currency: currency,
      network: network,
      amount: amount,
    );
  }

  @override
  FetchCryptoSellQuoteProvider getProviderOverride(
    covariant FetchCryptoSellQuoteProvider provider,
  ) {
    return call(
      currency: provider.currency,
      network: provider.network,
      amount: provider.amount,
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
  String? get name => r'fetchCryptoSellQuoteProvider';
}

/// See also [fetchCryptoSellQuote].
class FetchCryptoSellQuoteProvider
    extends AutoDisposeFutureProvider<CryptoSellQuoteModel?> {
  /// See also [fetchCryptoSellQuote].
  FetchCryptoSellQuoteProvider({
    required String currency,
    required String network,
    required double amount,
  }) : this._internal(
          (ref) => fetchCryptoSellQuote(
            ref as FetchCryptoSellQuoteRef,
            currency: currency,
            network: network,
            amount: amount,
          ),
          from: fetchCryptoSellQuoteProvider,
          name: r'fetchCryptoSellQuoteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchCryptoSellQuoteHash,
          dependencies: FetchCryptoSellQuoteFamily._dependencies,
          allTransitiveDependencies:
              FetchCryptoSellQuoteFamily._allTransitiveDependencies,
          currency: currency,
          network: network,
          amount: amount,
        );

  FetchCryptoSellQuoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currency,
    required this.network,
    required this.amount,
  }) : super.internal();

  final String currency;
  final String network;
  final double amount;

  @override
  Override overrideWith(
    FutureOr<CryptoSellQuoteModel?> Function(FetchCryptoSellQuoteRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchCryptoSellQuoteProvider._internal(
        (ref) => create(ref as FetchCryptoSellQuoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currency: currency,
        network: network,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CryptoSellQuoteModel?> createElement() {
    return _FetchCryptoSellQuoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCryptoSellQuoteProvider &&
        other.currency == currency &&
        other.network == network &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);
    hash = _SystemHash.combine(hash, network.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchCryptoSellQuoteRef
    on AutoDisposeFutureProviderRef<CryptoSellQuoteModel?> {
  /// The parameter `currency` of this provider.
  String get currency;

  /// The parameter `network` of this provider.
  String get network;

  /// The parameter `amount` of this provider.
  double get amount;
}

class _FetchCryptoSellQuoteProviderElement
    extends AutoDisposeFutureProviderElement<CryptoSellQuoteModel?>
    with FetchCryptoSellQuoteRef {
  _FetchCryptoSellQuoteProviderElement(super.provider);

  @override
  String get currency => (origin as FetchCryptoSellQuoteProvider).currency;
  @override
  String get network => (origin as FetchCryptoSellQuoteProvider).network;
  @override
  double get amount => (origin as FetchCryptoSellQuoteProvider).amount;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
