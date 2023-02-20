import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class AppOrangeBtn extends StatelessWidget {
  final String label;
  final double height;
  final double? weight;
  final VoidCallback? onTap;
  final bool isBusy;

  const AppOrangeBtn({
    Key? key,
    required this.label,
    this.height = 72,
    this.weight,
    this.onTap,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: MediaQuery.of(context).size.width,
      disabledColor: AppColors.primary.withOpacity(0.5),
      color: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Container(
        height: height,
        padding: EdgeInsets.only(top: 20.r),
        alignment: Alignment.topCenter,
        child: Visibility(
          visible: !isBusy,
          replacement: const SizedBox.square(
            child: FittedBox(
              child: AppLoader(
                padding: 0,
                size: 25,
                color: AppColors.black,
              ),
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.medium20.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
