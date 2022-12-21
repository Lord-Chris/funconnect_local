import 'package:flutter/material.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class AppOrangeBtn extends StatelessWidget {
  final String label;
  final double height;
  final double? weight;
  final VoidCallback? onTap;
  final double bottomPadding;
  final bool isBusy;

  const AppOrangeBtn({
    Key? key,
    required this.label,
    this.height = 80,
    this.weight,
    this.onTap,
    this.bottomPadding = 0,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(bottom: (height * 0.1) + bottomPadding),
      color: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(36),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Visibility(
          visible: !isBusy,
          replacement: const SizedBox.square(
            child: FittedBox(
              child: AppLoader(
                padding: 15,
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
