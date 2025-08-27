import 'package:zeelpay/constants/assets/png.dart';

getNetWorkIcon(String name) {
  if (name.toLowerCase().contains("mtn")) {
    return ZeelPng.mtn;
  } else if (name.toLowerCase().contains("glo")) {
    return ZeelPng.glo;
  } else if (name.toLowerCase().contains("airtel")) {
    return ZeelPng.airtel;
  } else {
    return ZeelPng.mobile;
  }
}
