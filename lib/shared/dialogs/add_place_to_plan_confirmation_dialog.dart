import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPlamToPlaceConfirmationDialog extends StatelessWidget {
  const AddPlamToPlaceConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Container(
          child: const Column(children: []),
        ));
  }
}
