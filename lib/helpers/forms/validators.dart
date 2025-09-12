String? emailValidator(String? value) {
  // Basic email pattern
  final RegExp emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (value == null || value.isEmpty) {
    return 'Please enter your username or email';
  } else if (!emailPattern.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null; // Indicates that the input is valid
}

String? passwordValidator(String? value) {
  // Define minimum length
  const int minLength = 6;
  if (value == null || value.isEmpty) {
    return 'Please enter your password, it’s required';
  } else if (value.length < minLength) {
    return 'Password must be at least $minLength characters long';
  }
  // } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
  //   return 'Password must contain both letters and numbers';
  // }
  return null; // Indicates that the input is valid
}

String? securityPinValidator(String? value) {
  // Define minimum length
  const int minLength = 4;
  if (value == null || value.isEmpty) {
    return 'Please enter your security pin';
  } else if (value.length < minLength) {
    return 'Security pin must be at least $minLength characters long';
  }
  return null; // Indicates that the input is valid
}

String? phoneNumberValidator(String? value) {
  // Basic phone number pattern (adjust as needed for specific requirements)
  final RegExp phonePattern = RegExp(r'^\+?[0-9]{10,15}$');
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  } else if (value.length < 11) {
    return 'Phone number must be 11 digits';
  } else if (!phonePattern.hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null; // Indicates that the input is valid
}

String? usernameValidator(String? value) {
  // Define minimum length
  const int minLength = 3;
  if (value == null || value.isEmpty) {
    return 'Please enter your username';
  } else if (value.length < minLength) {
    return 'Username must be at least $minLength characters long';
  } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
    return 'Username can only contain letters, numbers, and underscores';
  }
  return null; // Indicates that the input is valid
}

//otp validator
String? otpValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the OTP';
  } else if (value.length != 6) {
    return 'OTP must be 6 characters long';
  }
  return null; // Indicates that the input is valid
}

//full name validator
String? fullNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  } else if (value.length < 3) {
    return 'Full name must be at least 3 characters long';
  }
  return null; // Indicates that the input is valid
}

//country validator
String? countryValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select a country';
  }
  return null; // Indicates that the input is valid
}

//couponvalidator
String? couponValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the coupon code';
  } else if (value.length < 3) {
    return 'Coupon code must be at least 3 characters long';
  }
  return null; // Indicates that the input is valid
}

//amount validator
String? amountValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the amount';
  } else if (value.isEmpty) {
    return 'Amount must be at least 1 digit';
  }
  return null; // Indicates that the input is valid
}

//address validator
String? addressValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your address';
  } else if (value.length < 3) {
    return 'Address must be at least 3 characters long';
  }
  return null; // Indicates that the input is valid
}

//country validator
String? packageValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select a Package';
  }
  return null; // Indicates that the input is valid
}
