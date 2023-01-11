class ApiConstants {
  ApiConstants._();
  static const baseUrl = "https://api.funconnect.app/";

  // Sections
  static const auth = "${baseUrl}auth/";
  static const event = "${baseUrl}events/";

  //
  static get checkEmail => "${auth}check-email";
  static get requestOtp => "${auth}login/send-otp";
  static get loginWithOtp => "${auth}login/otp";
  static get createEvent => "${event}events";
}
