import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/utils/failure_handler.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:logger/logger.dart';

import 'i_dynamic_link_service.dart';

/// example of short link
/// `https://funconnect.page.link/E23AYzob1DyPojZm7`
///
///
/// example of long link
/// `https://funconnect.page.link?utm_campaign=example-promo&sd=A%20joint%20where%20all%20things%20fun%20are%20made%20to%20happen!&st=Welcome%20to%20GoodTime...&amv=0&apn=com.devmike.goodtime_app&link=https%3A%2F%2Fgoodtime.gt%2Fcommunity%3F98da8b9e-a5fa-48f1-b464-803b0d7c2d72&utm_medium=social&utm_source=orkut`
///
///
/// format of the deep link
/// `https://funconnect.app?[type]=type&[id]=id`
///
/// Note that if the [firebaseDomain] url is changed it must be changed in the
/// android manifest
class DynamicLinkService extends IDynamicLinkService {
  static const appId = "com.funconnect.app";
  static const firebaseDomain = "https://funconnect.page.link";
  static const funconnectHost = "www.funconnect.app";
  final _log = Logger();
  final _linkStreamController = StreamController<DeepLinkDataModel>.broadcast();

  @override
  DeepLinkDataModel? data;

  @override
  Future<void> init() async {
    try {
      final dynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();

      if (dynamicLink != null) {
        final Uri deepLink = dynamicLink.link;
        _log.i('DEEPLINK IS $deepLink');
        _handleData(deepLink.toString());
      }

      FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
        final Uri deepLink = dynamicLink.link;
        _handleData(deepLink.toString());
      }).onError((error) {
        _log.e(error.toString());
      });
    } on Exception catch (e, s) {
      _log.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
    }
  }

  void _handleData(String query) {
    final queryParams = Uri.parse(query).queryParameters;
    _log.i('Dynamic Link Data: $queryParams');
    data = DeepLinkDataModel.fromMap(queryParams);
    _linkStreamController.sink.add(data!);
    assert(data != null);
  }

  Uri _getLinkFromShareModel(DeepLinkDataModel data) {
    return Uri(
      scheme: 'https',
      host: funconnectHost,
      queryParameters: data.toMap(),
    );
  }

  @override
  Future<String> generateLink({
    required String desc,
    String? image,
    required DeepLinkDataModel data,
  }) async {
    try {
      Uri deepLink = _getLinkFromShareModel(data);

      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: firebaseDomain,
        link: deepLink,
        androidParameters: AndroidParameters(
          packageName: appId,
          fallbackUrl: Uri.parse(funconnectHost),
        ),
        iosParameters: IOSParameters(
          bundleId: appId,
          fallbackUrl: Uri.parse(funconnectHost),
          ipadFallbackUrl: Uri.parse(funconnectHost),
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: AppConstants.appName,
          description: desc,
          imageUrl: image != null ? Uri.parse(image) : null,
        ),
      );

      final dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(
        parameters,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );
      return dynamicUrl.shortUrl.toString();
    } on Exception catch (e, s) {
      _log.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      throw const Failure("Could not generate Link");
    }
  }

  @override
  Future<void> shareLink(String link) async {
    await GeneralUtils.shareText(link);
  }

  @override
  void clearData() {
    data = null;
  }

  @override
  Stream<DeepLinkDataModel> get linkStream =>
      _linkStreamController.stream.distinct();
}
// https://pastebin.com/MujJ6jM4