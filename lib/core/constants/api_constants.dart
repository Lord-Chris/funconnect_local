class ApiConstants {
  ApiConstants._();
  static const baseUrl = "https://api.funconnect.app";

  // Sections
  static const auth = "$baseUrl/auth";
  static const core = "$baseUrl/core";

  //
  static get checkEmail => "$auth/check-email";
  static get requestOtp => "$auth/login/send-otp";
  static get loginWithOtp => "$auth/login/otp";
  static get loginWithGoogle => "$auth/login/google";

  //
  static get profileSetup => "$core/profile";
}
