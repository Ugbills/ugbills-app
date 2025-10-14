class MobileEndpoints {
  // Mobile API Base URL - Separate from web API
  static const baseUrl = 'https://ugbills.zappyglobal.ng/api/mobile/v1/';

  // Mobile Authentication Endpoints
  static const auth = '${baseUrl}auth/';
  static const login = '${auth}login';
  static const pinLogin = '${auth}login/pin';
  static const register = '${auth}register';
  static const forgotPassword = '${auth}password-reset';
  static const resetPassword = '${auth}password-reset/complete';

  // Mobile User Endpoints
  static const user = '${baseUrl}me';
  static const logout = '${baseUrl}logout';
  static const userSettings = '${baseUrl}settings/';
  static const changePassword = '${userSettings}changepassword';
  static const updateProfile = '${userSettings}profile';
  static const setPin = '${userSettings}pin';
  static const notifications = '${userSettings}notification';
  static const nextOfKin = '${userSettings}next-of-kin';

  // Mobile Transaction Endpoints
  static const transactions = '${baseUrl}transactions';
  static const transactionDetails = '${baseUrl}transaction/';

  // Mobile Fund Endpoints
  static const fund = '${baseUrl}fund/';
  static const atmFund = '${fund}atm';
  static const deposit = '${fund}deposit';
  static const depositDetails = deposit; // GET for details, POST for logging

  // Mobile Withdrawal Endpoints
  static const withdraw = '${baseUrl}withdraw/';
  static const withdrawWallet = '${withdraw}wallet';
  static const withdrawBank = '${withdraw}bank';
  static const bankList = '${withdraw}bank';

  // Mobile Bill Payment Endpoints
  static const airtime = '${baseUrl}airtime';
  static const data = '${baseUrl}data';
  static const databundle = '${baseUrl}databundle';
  static const internet = '${baseUrl}internet';
  static const cable = '${baseUrl}cable';
  static const cableVerify = '$cable/verify';
  static const electricity = '${baseUrl}electricity';
  static const electricityVerify = '$electricity/verify';
  static const pins = '${baseUrl}pins';

  // Mobile Validation Endpoints
  static const validation = '${baseUrl}validation/';
  static const validateBank = '${validation}bank';
  static const validateBvn = '${validation}bvn';
  static const validateNin = '${validation}nin';
  static const validatePhone = '${validation}phone';
  static const validateUser = '${validation}user';
  static const validateWallet = '${validation}wallet';

  // Mobile Transfer Endpoints
  static const transfer = '${baseUrl}transfer/';
  static const walletTransfer = '${transfer}wallet';
  static const bankTransfer = '${transfer}bank';

  // Mobile Misc Endpoints
  static const referrals = '${baseUrl}referrals';
  static const upgrade = '${baseUrl}upgrade';
  static const upgradeAgent = '$upgrade/agent';
  static const support = '${baseUrl}misc/support';
}

// Legacy endpoints (keep for backward compatibility during transition)
class Endpoints {
  // Base URL
  static const baseUrl = 'https://devapi.UgBills.app/api/v1/';

  // Auth - Now points to mobile endpoints
  static const auth = 'auth/';
  static const login = '${auth}login';
  static const passwordLogin = login;
  static const pinLogin = '$login/pin';
  static const signup = '${auth}signup';
  static const verifyEmail = '${auth}verify/email';
  static const resendEmailVerify = '${auth}resend/email';
  static const createAccount = '${auth}create_user_account';
  static const recoverPassword = '${auth}reset/send-otp';
  static const resetPin = '${auth}reset/pin';
  static const resetPassword = '${auth}reset/password';

  // User
  static const user = '${baseUrl}user';
  static const userSetPin = '$user/pin/set';
  static const currentLevel = '$user/current-level';
  static const userDocUpload = '$user/document/any';
  static const changePassword = '$user/change-password';
  static const profileImage = '$user/profile-image';
  static const accountStatement = '$user/statement';

  static const userNotificationToken = '$user/notification/token';

  static const userNotifications = '$user/notifications/';
  static const userTransactions = '$user/transactions';
  static const userBeneficiaries = '$user/bank/beneficiaries';
  static const userReferrals = '$user/refferals';
  static const userDelete = '$user/account/close';
  static const bvnUpdate = '$user/upgrade/level2/submit';
  static const addressUpdate = '$user/upgrade/level3';

  //coupon
  static const redeemCoupon = '${baseUrl}coupon/redeem';

  //bills
  static const networks = '${baseUrl}sme/networks';
  static const dataPlans = '${baseUrl}sme/data?network_id=';
  static const cable = '${baseUrl}cabletv/';
  static const cableValidate = '${cable}resolve';
  static const cableBuy = '${cable}buy';
  static const electricity = '${baseUrl}electricity/';
  static const electricityValidate = '${electricity}resolve';
  static const electricityProviders = '${electricity}plans';
  static const electricityBuy = '${electricity}buy';
  static const betting = '${baseUrl}betting/';
  static const bettingBuy = '${betting}buy';
  static const bettingPlans = '${betting}plans';
  static const airtime = '${baseUrl}sme/airtime';
  static const data = '${baseUrl}sme/data';

//swap endpoints
  static const swap = '${baseUrl}sme/swap';
  static const swapInitiate = '$swap/start';
  static const swapConfirm = '$swap/send';

// transfer endpoints
  static const funding = '${baseUrl}funding';
  static const transfer = '${baseUrl}transfer';
  static const virtualAccount = '$transfer/accounts';
  static const oneTimeAccount = '$transfer/bank/one-time';
  static const transferBankList = '$transfer/banklist';
  static const transferBankValidate = '$transfer/validate';
  static const fundingValidate = '$funding/validate';
  static const fundingInitiate = '$funding/send';

  static const transferInitiate = '$transfer/transfer';

// CRYPTO ENDPOINTS

  static const crypto = '${baseUrl}crypto';
  static const cryptoList = '$crypto/supported';
  static const cryptoBuyQuote = '$crypto/buy-quote?currency=';
  static const cryptoSellQuote = '$crypto/sell-quote?currency=';
  static const cryptoBuy = '$crypto/buy';
  static const cryptoSell = '$crypto/sell';

// Card Endpoints

  static const card = '${baseUrl}card';
  static const cardTypes = '$card/types/all';
  static const cardStatus = '$card/get-customer';
  static const cardApply = '$card/apply';
  static const cardList = '$card/all';
  static const cardDetails = '$card/card-details';
  static const cardTransactions = '$card/transactions';
  static const cardCreate = '$card/create';
  static const cardDelete = '$card/delete';
  static const cardFreeze = '$card/freeze';
  static const cardUnFreeze = '$card/unfreeze';
  static const cardFund = '$card/fund';
  static const cardWithdraw = '$card/withdraw';
  static const cardUpdate = '$card/update';

  //gift card endpoints

  static const giftCard = '${baseUrl}giftcard';
  static const giftCardCountries = '$giftCard/countries';
  static const giftCardBrands = '$giftCard/cards';
  static const giftCardBuy = '$giftCard/buy';
}
