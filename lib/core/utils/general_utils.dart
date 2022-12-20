import 'package:flutter/services.dart';

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
}
