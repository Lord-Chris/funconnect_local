import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/shared/components/video_player_widget.dart';

import '../../../../shared/constants/colors.dart';

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
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const VideoPlayerWidget(),
        ),
        Positioned(
          bottom: -20.0,
          left: 0,
          right: 0,
          child: Container(
            padding: padding,
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
