import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/plans/presentation/blocs/create_plan_bloc/create_plan_bloc.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:logger/logger.dart';

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
                onTap: () {
                  Logger().d("Remove friend");
                  context.read<CreatePlanBloc>().add(RemoveFriendEvent(email));
                },
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
            email,
            style: TextStyle(fontSize: 10.sp),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
