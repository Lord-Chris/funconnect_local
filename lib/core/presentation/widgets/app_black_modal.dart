import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/colors.dart';

class AppBlackModalWidget extends StatelessWidget {
  final List<Widget> children;
  final double? modalHeight;
  final double? imageContainerHeight;
  final EdgeInsets? padding;
  final bool showBackButton;

  const AppBlackModalWidget({
    Key? key,
    required this.children,
    this.modalHeight,
    this.imageContainerHeight,
    this.padding,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            height: imageContainerHeight ?? 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/registerIMG.jpg",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          bottom: -20.0,
          child: Container(
            // height: modalHeight ?? 350,
            padding: padding,
            constraints: modalHeight != null
                ? BoxConstraints(maxHeight: modalHeight!)
                : null,
            width: MediaQuery.of(context).size.width,
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
