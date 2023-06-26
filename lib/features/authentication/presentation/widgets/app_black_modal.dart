import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class AppBlackModalWidget extends StatelessWidget {
  final List<Widget> children;
  final double? modalHeight;
  final double? imageContainerHeight;
  final EdgeInsets? padding;
  final bool showBackButton;
  final Widget? topIcon;

  const AppBlackModalWidget({
    Key? key,
    required this.children,
    this.modalHeight,
    this.imageContainerHeight,
    this.padding,
    this.showBackButton = false,
    this.topIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            AppAssets.authFlowPng,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 12.0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              Container(
                padding: padding,
                margin: EdgeInsets.only(top: 32.r),
                constraints: modalHeight != null
                    ? BoxConstraints(maxHeight: modalHeight!)
                    : null,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ),
              if (topIcon != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 32.r,
                    backgroundColor: AppColors.interestWidgetAsh,
                    child: topIcon,
                  ),
                ),
            ],
          ),
        ),
        if (showBackButton)
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(
                CupertinoIcons.back,
                color: AppColors.white,
              ),
            ),
          ),
      ],
    );
  }
}
