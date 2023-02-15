import 'package:funconnect/core/models/_models.dart';

class ApiConstants {
  ApiConstants._();
  static const _baseUrl = "https://api.funconnect.app";

  // Sections
  static const _auth = "$_baseUrl/auth";
  static const _core = "$_baseUrl/core";
  static const places = "$_baseUrl/places";

  // AUTH
  static get checkEmail => "$_auth/check-email";
  static get requestOtp => "$_auth/login/send-otp";
  static get loginWithOtp => "$_auth/login/otp";
  static get loginWithGoogle => "$_auth/login/google";

  //
  static get profileSetup => "$_core/profile";

  // PLACES
  static String homeTrends(AppLocation? loc) {
    if (loc == null) return "$places/home-trends";
    return "$places/home-trends?lat=${loc.lat}&long=${loc.long}&city=${loc.city}&state=${loc.state}&country=${loc.country}";
  }

  static get categories => "$places/categories";
  static String singlePlace(String placeId) => "$places/$placeId";
  static String placeReview(String placeId) => "$places/reviews/$placeId";

  // EVENTS
  static get events => "$_baseUrl/events";
}
