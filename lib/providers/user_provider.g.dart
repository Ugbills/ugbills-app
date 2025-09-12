// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchUserInformationHash() =>
    r'8d8981f4459527cf690aa23b7896464931a4b19f';

/// See also [fetchUserInformation].
@ProviderFor(fetchUserInformation)
final fetchUserInformationProvider =
    AutoDisposeFutureProvider<UserModel?>.internal(
  fetchUserInformation,
  name: r'fetchUserInformationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchUserInformationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchUserInformationRef = AutoDisposeFutureProviderRef<UserModel?>;
String _$fetchUserBeneficiariesHash() =>
    r'eda24765bf886a6d73c9a1a515ea2b6dd29b9fef';

/// See also [fetchUserBeneficiaries].
@ProviderFor(fetchUserBeneficiaries)
final fetchUserBeneficiariesProvider =
    AutoDisposeFutureProvider<BeneficiariesModel?>.internal(
  fetchUserBeneficiaries,
  name: r'fetchUserBeneficiariesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchUserBeneficiariesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchUserBeneficiariesRef
    = AutoDisposeFutureProviderRef<BeneficiariesModel?>;
String _$fetchUserReferralsHash() =>
    r'3e75d9decd419552d57acfaa5af2631474abf9b3';

/// See also [fetchUserReferrals].
@ProviderFor(fetchUserReferrals)
final fetchUserReferralsProvider =
    AutoDisposeFutureProvider<ReferralsModel?>.internal(
  fetchUserReferrals,
  name: r'fetchUserReferralsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchUserReferralsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchUserReferralsRef = AutoDisposeFutureProviderRef<ReferralsModel?>;
String _$oneTimeAccountHash() => r'3eea832ef4c8dff9a55c5cea0781426c8c46d747';

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

/// See also [oneTimeAccount].
@ProviderFor(oneTimeAccount)
const oneTimeAccountProvider = OneTimeAccountFamily();

/// See also [oneTimeAccount].
class OneTimeAccountFamily extends Family<AsyncValue<OneTimeBank?>> {
  /// See also [oneTimeAccount].
  const OneTimeAccountFamily();

  /// See also [oneTimeAccount].
  OneTimeAccountProvider call({
    required dynamic amount,
  }) {
    return OneTimeAccountProvider(
      amount: amount,
    );
  }

  @override
  OneTimeAccountProvider getProviderOverride(
    covariant OneTimeAccountProvider provider,
  ) {
    return call(
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
  String? get name => r'oneTimeAccountProvider';
}

/// See also [oneTimeAccount].
class OneTimeAccountProvider extends AutoDisposeFutureProvider<OneTimeBank?> {
  /// See also [oneTimeAccount].
  OneTimeAccountProvider({
    required dynamic amount,
  }) : this._internal(
          (ref) => oneTimeAccount(
            ref as OneTimeAccountRef,
            amount: amount,
          ),
          from: oneTimeAccountProvider,
          name: r'oneTimeAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$oneTimeAccountHash,
          dependencies: OneTimeAccountFamily._dependencies,
          allTransitiveDependencies:
              OneTimeAccountFamily._allTransitiveDependencies,
          amount: amount,
        );

  OneTimeAccountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.amount,
  }) : super.internal();

  final dynamic amount;

  @override
  Override overrideWith(
    FutureOr<OneTimeBank?> Function(OneTimeAccountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OneTimeAccountProvider._internal(
        (ref) => create(ref as OneTimeAccountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OneTimeBank?> createElement() {
    return _OneTimeAccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OneTimeAccountProvider && other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OneTimeAccountRef on AutoDisposeFutureProviderRef<OneTimeBank?> {
  /// The parameter `amount` of this provider.
  dynamic get amount;
}

class _OneTimeAccountProviderElement
    extends AutoDisposeFutureProviderElement<OneTimeBank?>
    with OneTimeAccountRef {
  _OneTimeAccountProviderElement(super.provider);

  @override
  dynamic get amount => (origin as OneTimeAccountProvider).amount;
}

String _$fetchUserVirtualAccountHash() =>
    r'c9f8baf1cf619bf3a6200f034edc5b257715446c';

/// See also [fetchUserVirtualAccount].
@ProviderFor(fetchUserVirtualAccount)
final fetchUserVirtualAccountProvider =
    AutoDisposeFutureProvider<BankAccountModel?>.internal(
  fetchUserVirtualAccount,
  name: r'fetchUserVirtualAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchUserVirtualAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchUserVirtualAccountRef
    = AutoDisposeFutureProviderRef<BankAccountModel?>;
String _$fetchAccountLevelHash() => r'd2d7aff58c614f57c0d8cd7978745b176f11d7b2';

/// See also [fetchAccountLevel].
@ProviderFor(fetchAccountLevel)
final fetchAccountLevelProvider =
    AutoDisposeFutureProvider<AccountLevelModel?>.internal(
  fetchAccountLevel,
  name: r'fetchAccountLevelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAccountLevelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAccountLevelRef = AutoDisposeFutureProviderRef<AccountLevelModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
