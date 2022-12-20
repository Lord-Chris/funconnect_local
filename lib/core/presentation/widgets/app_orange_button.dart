import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class AppOrangeBtn extends StatelessWidget {
  final String label;
  final double height;
  final double? weight;
  final VoidCallback? onTap;

  const AppOrangeBtn({
    Key? key,
    required this.label,
    this.height = 80,
    this.weight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(bottom: height * 0.1),
      color: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(36),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          label,
          style: AppTextStyles.medium20.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
