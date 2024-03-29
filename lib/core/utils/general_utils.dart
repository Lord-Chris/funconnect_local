import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:logger/logger.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart' as smtp;
import 'package:share_plus/share_plus.dart';
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

  static Future<void> openAppRelatedUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Failure('Could not launch $url');
    }
  }

  static Future<void> updateApp() async {
    await StoreRedirect.redirect();
  }

  static Future<void> shareText(String text) async {
    try {
      await Share.share(text, subject: AppConstants.appName);
    } on Exception catch (e) {
      throw Failure("Could not share text", extraData: e.toString());
    }
  }

  static String parseTime(int timeInSeconds) {
    int timeMin = timeInSeconds ~/ 60;
    if (timeMin < 1) return "$timeInSeconds secs";
    int timeHr = timeInSeconds ~/ (60 * 60);
    if (timeHr < 1) return "$timeMin mins";
    int timeDay = timeInSeconds ~/ (60 * 60 * 24);
    if (timeDay < 1) return "$timeHr hrs";
    int timeWeek = timeInSeconds ~/ (60 * 60 * 24 * 7);
    if (timeWeek < 1) return "$timeDay days";
    int timeMths = timeInSeconds ~/ (60 * 60 * 24 * 7 * 30);
    if (timeMths < 1) return "$timeWeek weeks";
    int timeYrs = timeInSeconds ~/ (60 * 60 * 24 * 7 * 30 * 12);
    if (timeYrs < 1) return "$timeMths months";
    return "$timeYrs years";
  }

  static Future<void> sendMail(String recipientEmail, HelpDeskData data) async {
    String username = 'support@funconnect.app';
    String password = 'A7UWis5fNQ9q';

    final smtpServer = smtp.zoho(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username, AppConstants.appName)
      ..recipients.addAll([username, recipientEmail])
      ..subject = data.title
      ..text = data.body;

    try {
      await send(message, smtpServer);
    } on MailerException catch (e) {
      // print('Message not sent.');
      Logger().e(e);
      for (var p in e.problems) {
        Logger().d('Problem: ${p.code}: ${p.msg}');
      }
      throw Failure(e.message, extraData: e.problems.toString());
    }
  }
}
