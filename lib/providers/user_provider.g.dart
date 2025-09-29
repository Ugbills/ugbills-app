// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchUserInformationHash() =>
    r'd287fbd3524ecc62e062db90638f65f571a296ae';

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
String _$fetchMobileUserInformationHash() =>
    r'95d54cdf1ecdb6e3ae027afbe4ae010a7a56b808';

/// See also [fetchMobileUserInformation].
@ProviderFor(fetchMobileUserInformation)
final fetchMobileUserInformationProvider =
    AutoDisposeFutureProvider<UserModel?>.internal(
  fetchMobileUserInformation,
  name: r'fetchMobileUserInformationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchMobileUserInformationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchMobileUserInformationRef
    = AutoDisposeFutureProviderRef<UserModel?>;
String _$fetchUserBeneficiariesHash() =>
    r'1f1d5c7cd239e74109aed4283cc6c30b0b1b6917';

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
    r'094e4662e054516c7572a81f1edfecb813e2ca64';

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
String _$oneTimeAccountHash() => r'ad24b7f8df96c6d24038570464a2183468a0d7d7';

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
    r'a9c712eee1f6d6b168f35adac5195e3b0be363d0';

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
String _$fetchAccountLevelHash() => r'a636a44ef134c1d4754a3147ec002e3adbe79a06';

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
String _$fetchMobileDepositDetailsHash() =>
    r'0f8dfbd83b02b68efec1b8ab787d42a03c001889';

/// See also [fetchMobileDepositDetails].
@ProviderFor(fetchMobileDepositDetails)
final fetchMobileDepositDetailsProvider =
    AutoDisposeFutureProvider<DepositDetailsModel?>.internal(
  fetchMobileDepositDetails,
  name: r'fetchMobileDepositDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchMobileDepositDetailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchMobileDepositDetailsRef
    = AutoDisposeFutureProviderRef<DepositDetailsModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
