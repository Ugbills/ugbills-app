import 'package:intl/intl.dart';

String formartDate(String value) {
  DateTime parsedDate = DateTime.parse(value);
  return DateFormat('MMM d, yyyy').format(parsedDate);
}

String formartDateTime(String value) {
  DateTime parsedDate = DateTime.parse(value);
  return DateFormat('MMM d, yyyy hh:mm a').format(parsedDate);
}
