import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/providers/transaction_provider.dart';
import 'package:ugbills/providers/user_provider.dart';

Future refreshUser({required WidgetRef ref}) async {
  ref.refresh(fetchUserInformationProvider);
  ref.refresh(fetchUserTransactionsProvider());
}
