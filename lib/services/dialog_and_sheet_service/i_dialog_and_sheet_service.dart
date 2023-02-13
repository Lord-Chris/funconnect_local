import 'package:flutter/material.dart';

abstract class IDialogAndSheetService {
  Future<T?> showAppBottomSheet<T>(Widget child);
  Future<T?> showAppDialog<T>(Widget child);
}
