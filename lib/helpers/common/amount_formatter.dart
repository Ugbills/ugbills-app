import 'package:intl/intl.dart';

returnAmount(dynamic amount) {
  final value = NumberFormat("#,##0", "en_US");
  return value.format(amount);
}

returnUsdAmount(dynamic amount) {
  final value = NumberFormat("#,##0.00", "en_US");
  return value.format(amount);
}
