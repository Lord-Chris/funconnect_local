import 'package:flutter/cupertino.dart';

import '../../../shared/constants/colors.dart';

class AppBlackModalWidget extends StatelessWidget {
  List<Widget> children;
  double? modalHeight;
  double? imageContainerHeight;
  AppBlackModalWidget({
    required this.children,
    this.imageContainerHeight,
    this.modalHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
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
            height: modalHeight ?? 350,
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
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
