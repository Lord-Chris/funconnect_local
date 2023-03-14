import 'package:funconnect/core/enums/_enums.dart';
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
  static get logout => "$_auth/logout";
  static get deleteAccount => "$_auth/delete-account";

  //PROFILE
  static get profileSetup => "$_core/profile";
  static get profileImage => "$profileSetup/image";
  static get profileLocationSetup => "$_core/profile/location";
  static get profileImageSetup => "$_core/profile/image";

  // PLACES
  static get categories => "$places/categories";
  static get userInterests => "$places/user/interests";
  static String singlePlace(String placeId) => "$places/$placeId";
  static String placeReview(String placeId) => "$places/reviews/$placeId";
  static String exploreFilter(ExploreSearchEnum filter) =>
      "$places/explore?filter_by=${filter.value}";
  static String homeTrends(AppLocation? loc) {
    if (loc == null) return "$places/home-trends";
    return "$places/home-trends?lat=${loc.lat}&long=${loc.long}&city=${loc.city}&state=${loc.state}&country=${loc.country}";
  }

  static String categoryPlaces(String catId, AppLocation? loc) {
    if (loc == null) return "$places/category/$catId";
    return "$places/category/$catId?lat=${loc.lat}&long=${loc.long}&city=${loc.city}&state=${loc.state}&country=${loc.country}";
  }

  static String explore(AppLocation? loc) {
    if (loc == null) return "$places/explore";
    return "$places/explore?lat=${loc.lat}&long=${loc.long}&city=${loc.city}&state=${loc.state}&country=${loc.country}";
  }

  static String bookmarkPlace(String placeId) =>
      '$places/saved-places/$placeId';
  static String unBookmarkPlace(String savedPlaceId) =>
      '$places/saved-places/$savedPlaceId';

  // EVENTS
  static get events => "$_baseUrl/events";

  //SAVED
  static get savedPlaces => "$places/saved-places";

  static get imageKey => 'image';

  // GENERAL
  static get notifications => "$_core/notifications";
  static get readAllNotification => "$notifications/mark-all-as-read";
}
