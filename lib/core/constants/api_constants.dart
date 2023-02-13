import 'package:funconnect/core/models/_models.dart';

class ApiConstants {
  ApiConstants._();
  static const _baseUrl = "https://api.funconnect.app";

  // Sections
  static const _auth = "$_baseUrl/auth";
  static const _core = "$_baseUrl/core";
  static const _places = "$_baseUrl/places";

  // AUTH
  static get checkEmail => "$_auth/check-email";
  static get requestOtp => "$_auth/login/send-otp";
  static get loginWithOtp => "$_auth/login/otp";
  static get loginWithGoogle => "$_auth/login/google";

  //
  static get profileSetup => "$_core/profile";

  // PLACES
  static String homeTrends(AppLocation? loc) =>
      "$_places/home-trends?lat=${loc?.lat}&long=${loc?.long}&city=${loc?.city}&state=${loc?.state}&country=${loc?.country}";
  static get categories => "$_places/categories";
  static String singlePlace(String placeId) => "$_places/$placeId";
  static String placeReview(String placeId) => "$_places/reviews/$placeId";

  // EVENTS
  static get events => "$_baseUrl/events";
}
