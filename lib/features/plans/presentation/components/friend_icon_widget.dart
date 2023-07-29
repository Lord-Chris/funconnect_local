import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/constants/app_assets.dart';

class FriendIconWidget extends StatelessWidget {
  final String email;
  const FriendIconWidget({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 65.h,
      child: Column(
        children: [
          SvgPicture.asset(
            AppAssets.planFriendSvg,
            height: 40.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            email,
            style: TextStyle(fontSize: 10.sp),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
