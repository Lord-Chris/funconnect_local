import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funconnect/core/models/failure.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralUtils {
  GeneralUtils._();

  static Stream<String?> checkClipBoard() async* {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!await Clipboard.hasStrings()) yield null;
    final res = await Clipboard.getData('text/plain');
    if (res == null) {
      yield null;
    } else if (res.text == null) {
      yield null;
    } else if (res.text!.length != 6) {
      yield null;
    } else if (!RegExp(r'[0-9]').hasMatch(res.text!)) {
      yield null;
    } else {
      yield res.text!;
    }
  }

  static String hideEmail(String email) {
    if (email.substring(0, email.indexOf('@')).length < 3) {
      return email.replaceRange(0, email.indexOf('@'), '*****');
    }
    return email.replaceRange(1, email.indexOf('@') - 1, '*****');
  }

  static TimeOfDay stringToTimeOfDay(String time) {
    assert(RegExp(r'[0-9][0-9]:[0-9][0-9]:[0-9][0-9]').hasMatch(time));
    final data = time.split(":");
    return TimeOfDay(hour: int.parse(data[0]), minute: int.parse(data[1]));
  }

  static Future<void> openUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Failure('Could not launch $url');
    }
  }

  static Future<void> updateApp() async {
    await StoreRedirect.redirect();
  }
}
