class Endpoints {
  // Base URL
  static const baseUrl = 'https://devapi.zeelpay.app/api/v1/';

  // Auth
  static const auth = 'auth/';
  static const login = '${auth}login/';
  static const passwordLogin = '${login}password';
  static const pinLogin = '${login}pin';
  static const signup = '${auth}signup';
  static const verifyEmail = '${auth}verify/email';
  static const resendEmailVerify = '${auth}resend/email';
  static const createAccount = '${auth}create_user_account';
  static const recoverPassword = '${auth}reset/send-otp';
  static const resetPassword = '${auth}reset/password';

  // User
  static const user = '${baseUrl}user';
  static const avatar = '$user/avatar';
}
