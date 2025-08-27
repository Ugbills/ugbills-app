class NetworkHelper {
  static String getNetworkName({required int networkId}) {
    switch (networkId) {
      case 1:
        return "MTN";
      case 2:
        return "Airtel";
      case 3:
        return "9Mobile";
      case 4:
        return "Glo";
      default:
        return "MTN";
    }
  }

  getNetworkId({required String beneficiary}) {
    if (mtn.contains(beneficiary.substring(0, 4))) {
      return 1;
    } else if (glo.contains(beneficiary.substring(0, 4))) {
      return 4;
    } else if (airtel.contains(beneficiary.substring(0, 4))) {
      return 2;
    } else if (etisalat.contains(beneficiary.substring(0, 4))) {
      return 3;
    } else {
      return 1;
    }
  }
}

var mtn = [
  "0703",
  "0706",
  "0803",
  "0806",
  "0810",
  "0813",
  "0814",
  "0816",
  "0903",
  "0906",
  "0704",
  "0913",
  "0702",
  "0916"
];

var glo = ["0705", "0805", "0807", "0815", "0905", "0811", "0915"];

var airtel = [
  "0701",
  "0708",
  "0802",
  "0808",
  "0812",
  "0902",
  "0907",
  "0901",
  "0904",
  "0912",
  "0911"
];
var etisalat = ["0809", "0817", "0818", "0909", "0908"];
