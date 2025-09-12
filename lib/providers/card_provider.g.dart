// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canCreateCardHash() => r'2114ac215ee4bb77977e73e6e61607dc7959d99f';

/// See also [canCreateCard].
@ProviderFor(canCreateCard)
final canCreateCardProvider = FutureProvider<bool?>.internal(
  canCreateCard,
  name: r'canCreateCardProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$canCreateCardHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CanCreateCardRef = FutureProviderRef<bool?>;
String _$getAllCardsHash() => r'96bc2f7a48a4fd6600f514c3c004a46807cd2cba';

/// See also [getAllCards].
@ProviderFor(getAllCards)
final getAllCardsProvider = AutoDisposeFutureProvider<CardsModel?>.internal(
  getAllCards,
  name: r'getAllCardsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllCardsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllCardsRef = AutoDisposeFutureProviderRef<CardsModel?>;
String _$getCardHash() => r'e226fde77958f79a1c9b696b24f23b0118d9f53e';

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

/// See also [getCard].
@ProviderFor(getCard)
const getCardProvider = GetCardFamily();

/// See also [getCard].
class GetCardFamily extends Family<AsyncValue<VirtualCardModel?>> {
  /// See also [getCard].
  const GetCardFamily();

  /// See also [getCard].
  GetCardProvider call({
    required String cardId,
  }) {
    return GetCardProvider(
      cardId: cardId,
    );
  }

  @override
  GetCardProvider getProviderOverride(
    covariant GetCardProvider provider,
  ) {
    return call(
      cardId: provider.cardId,
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
  String? get name => r'getCardProvider';
}

/// See also [getCard].
class GetCardProvider extends AutoDisposeFutureProvider<VirtualCardModel?> {
  /// See also [getCard].
  GetCardProvider({
    required String cardId,
  }) : this._internal(
          (ref) => getCard(
            ref as GetCardRef,
            cardId: cardId,
          ),
          from: getCardProvider,
          name: r'getCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCardHash,
          dependencies: GetCardFamily._dependencies,
          allTransitiveDependencies: GetCardFamily._allTransitiveDependencies,
          cardId: cardId,
        );

  GetCardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cardId,
  }) : super.internal();

  final String cardId;

  @override
  Override overrideWith(
    FutureOr<VirtualCardModel?> Function(GetCardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCardProvider._internal(
        (ref) => create(ref as GetCardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cardId: cardId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<VirtualCardModel?> createElement() {
    return _GetCardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCardProvider && other.cardId == cardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCardRef on AutoDisposeFutureProviderRef<VirtualCardModel?> {
  /// The parameter `cardId` of this provider.
  String get cardId;
}

class _GetCardProviderElement
    extends AutoDisposeFutureProviderElement<VirtualCardModel?>
    with GetCardRef {
  _GetCardProviderElement(super.provider);

  @override
  String get cardId => (origin as GetCardProvider).cardId;
}

String _$getCardTransactionsHash() =>
    r'5785da2a69e8bc0b0649b2e072339a50e40c6139';

/// See also [getCardTransactions].
@ProviderFor(getCardTransactions)
const getCardTransactionsProvider = GetCardTransactionsFamily();

/// See also [getCardTransactions].
class GetCardTransactionsFamily
    extends Family<AsyncValue<CardTransactionModel?>> {
  /// See also [getCardTransactions].
  const GetCardTransactionsFamily();

  /// See also [getCardTransactions].
  GetCardTransactionsProvider call({
    required String cardId,
  }) {
    return GetCardTransactionsProvider(
      cardId: cardId,
    );
  }

  @override
  GetCardTransactionsProvider getProviderOverride(
    covariant GetCardTransactionsProvider provider,
  ) {
    return call(
      cardId: provider.cardId,
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
  String? get name => r'getCardTransactionsProvider';
}

/// See also [getCardTransactions].
class GetCardTransactionsProvider
    extends AutoDisposeFutureProvider<CardTransactionModel?> {
  /// See also [getCardTransactions].
  GetCardTransactionsProvider({
    required String cardId,
  }) : this._internal(
          (ref) => getCardTransactions(
            ref as GetCardTransactionsRef,
            cardId: cardId,
          ),
          from: getCardTransactionsProvider,
          name: r'getCardTransactionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCardTransactionsHash,
          dependencies: GetCardTransactionsFamily._dependencies,
          allTransitiveDependencies:
              GetCardTransactionsFamily._allTransitiveDependencies,
          cardId: cardId,
        );

  GetCardTransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cardId,
  }) : super.internal();

  final String cardId;

  @override
  Override overrideWith(
    FutureOr<CardTransactionModel?> Function(GetCardTransactionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCardTransactionsProvider._internal(
        (ref) => create(ref as GetCardTransactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cardId: cardId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CardTransactionModel?> createElement() {
    return _GetCardTransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCardTransactionsProvider && other.cardId == cardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCardTransactionsRef
    on AutoDisposeFutureProviderRef<CardTransactionModel?> {
  /// The parameter `cardId` of this provider.
  String get cardId;
}

class _GetCardTransactionsProviderElement
    extends AutoDisposeFutureProviderElement<CardTransactionModel?>
    with GetCardTransactionsRef {
  _GetCardTransactionsProviderElement(super.provider);

  @override
  String get cardId => (origin as GetCardTransactionsProvider).cardId;
}

String _$getCardTypesHash() => r'22212a8249a6d57ce27e0e94060bec81a1b585d9';

/// See also [getCardTypes].
@ProviderFor(getCardTypes)
final getCardTypesProvider = AutoDisposeFutureProvider<CardTypeModel?>.internal(
  getCardTypes,
  name: r'getCardTypesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getCardTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCardTypesRef = AutoDisposeFutureProviderRef<CardTypeModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
