// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchUserTransactionsHash() =>
    r'4d2cf60307f6405f462170cce752fbf7146d3af8';

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

/// See also [fetchUserTransactions].
@ProviderFor(fetchUserTransactions)
const fetchUserTransactionsProvider = FetchUserTransactionsFamily();

/// See also [fetchUserTransactions].
class FetchUserTransactionsFamily
    extends Family<AsyncValue<List<Transaction>?>> {
  /// See also [fetchUserTransactions].
  const FetchUserTransactionsFamily();

  /// See also [fetchUserTransactions].
  FetchUserTransactionsProvider call({
    int? page = 1,
    int? limit = 10,
  }) {
    return FetchUserTransactionsProvider(
      page: page,
      limit: limit,
    );
  }

  @override
  FetchUserTransactionsProvider getProviderOverride(
    covariant FetchUserTransactionsProvider provider,
  ) {
    return call(
      page: provider.page,
      limit: provider.limit,
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
  String? get name => r'fetchUserTransactionsProvider';
}

/// See also [fetchUserTransactions].
class FetchUserTransactionsProvider
    extends AutoDisposeFutureProvider<List<Transaction>?> {
  /// See also [fetchUserTransactions].
  FetchUserTransactionsProvider({
    int? page = 1,
    int? limit = 10,
  }) : this._internal(
          (ref) => fetchUserTransactions(
            ref as FetchUserTransactionsRef,
            page: page,
            limit: limit,
          ),
          from: fetchUserTransactionsProvider,
          name: r'fetchUserTransactionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchUserTransactionsHash,
          dependencies: FetchUserTransactionsFamily._dependencies,
          allTransitiveDependencies:
              FetchUserTransactionsFamily._allTransitiveDependencies,
          page: page,
          limit: limit,
        );

  FetchUserTransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.limit,
  }) : super.internal();

  final int? page;
  final int? limit;

  @override
  Override overrideWith(
    FutureOr<List<Transaction>?> Function(FetchUserTransactionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUserTransactionsProvider._internal(
        (ref) => create(ref as FetchUserTransactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Transaction>?> createElement() {
    return _FetchUserTransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUserTransactionsProvider &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchUserTransactionsRef
    on AutoDisposeFutureProviderRef<List<Transaction>?> {
  /// The parameter `page` of this provider.
  int? get page;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _FetchUserTransactionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Transaction>?>
    with FetchUserTransactionsRef {
  _FetchUserTransactionsProviderElement(super.provider);

  @override
  int? get page => (origin as FetchUserTransactionsProvider).page;
  @override
  int? get limit => (origin as FetchUserTransactionsProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
