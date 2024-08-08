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
  } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
    return 'Password must contain both letters and numbers';
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
