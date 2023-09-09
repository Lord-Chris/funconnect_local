import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class FriendIconEmptyWidget extends StatelessWidget {
  const FriendIconEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 65.h,
      child: Column(
        children: [
          SvgPicture.asset(
            AppAssets.addFriendSvg,
            height: 40.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Add a Friend",
            style: TextStyle(fontSize: 10.sp, color: AppColors.gray97),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
