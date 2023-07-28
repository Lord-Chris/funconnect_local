import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/constants/colors.dart';

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
          Stack(
            children: [
              Positioned(
                child: CircleAvatar(
                  backgroundColor: AppColors.secondary700,
                  radius: 20.r,
                  child: const Icon(
                    Icons.person,
                    color: Color(0xff4d4d4d),
                    size: 20,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Positioned(
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xff4d4d4d),
                      radius: 8.r,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 10,
                      ),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Add a Friend",
            style: TextStyle(fontSize: 10.sp),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
