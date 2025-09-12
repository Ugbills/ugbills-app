import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactFormat {
  contact(PhoneContact? contact) {
    var phoneNumber = "";

    if (contact == null) {
      return phoneNumber;
    } else if (contact.phoneNumber!.number.toString().startsWith("+234")) {
      return contact.phoneNumber!.number
          .toString()
          .replaceAll("+234", "0")
          .replaceAll(" ", "");
    } else {
      return contact.phoneNumber!.number.toString().replaceAll(" ", "");
    }
  }
}
