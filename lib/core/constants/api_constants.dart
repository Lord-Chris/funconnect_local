import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/search_query_param.dart';

class ApiConstants {
  ApiConstants._();
  static const _baseUrl = "https://api.funconnect.app";

  // Sections
  static const _auth = "$_baseUrl/auth";
  static const _core = "$_baseUrl/core";
  static const places = "$_baseUrl/places";

  // AUTH
  static String get checkEmail => "$_auth/check-email";
  static String get requestOtp => "$_auth/login/send-otp";
  static String get loginWithOtp => "$_auth/login/otp";
  static String get loginWithGoogle => "$_auth/login/google";
  static String get logout => "$_auth/logout";
  static String get deleteAccount => "$_auth/delete-account";

  //PROFILE
  static String get profileSetup => "$_core/profile";
  static String get profileImage => "$profileSetup/image";
  static String get profileLocationSetup => "$_core/profile/location";
  static String get profileImageSetup => "$_core/profile/image";

  // PLACES
  static String get categories => "$places/categories";
  static String get userInterests => "$places/user/interests";
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

  static String searchPlaces(SearchQueryParam query, AppLocation? loc) {
    String url = "$places/search?";
    if (query.param.isNotEmpty) url += "sqr=${query.param.toLowerCase()}&";
    if (query.toSearchEnumParam.isEmpty && loc != null) {
      url +=
          "lat=${loc.lat}&long=${loc.long}&city=${loc.city}&state=${loc.state}&country=${loc.country}";
    }
    url += query.toParam;
    if (url.endsWith("&")) {
      url.replaceRange(url.lastIndexOf("&"), null, "");
    }
    return url;
  }

  static String explore(AppLocation? loc) {
    if (loc == null) return "$places/explore";
    return "$places/explore?lat=${loc.lat}&long=${loc.long}&city=${loc.city}&state=${loc.state}&country=${loc.country}";
  }

  static String togglePlaceBookmark(String placeId) =>
      '$places/saved-places/$placeId';

  // EVENTS
  static String get events => "$_baseUrl/events";

  //SAVED
  static String get savedPlaces => "$places/saved-places";

  static String get imageKey => 'image';

  // GENERAL
  static String get notifications => "$_core/notifications";
  static String get readAllNotification => "$notifications/mark-all-as-read";
}
