class ApiConstants {
  ApiConstants._();
  static const _baseUrl = "https://api.funconnect.app";

  // Sections
  static const _auth = "$_baseUrl/auth";
  static const _core = "$_baseUrl/core";
  static const _places = "$_baseUrl/places";

  //
  static get checkEmail => "$_auth/check-email";
  static get requestOtp => "$_auth/login/send-otp";
  static get loginWithOtp => "$_auth/login/otp";
  static get loginWithGoogle => "$_auth/login/google";

  //
  static get profileSetup => "$_core/profile";

  //
  static get categories => "$_places/categories";

  //
  static get createEvent => "${_baseUrl}events";
}
