import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/constants/colors.dart';
import '../../../../../shared/constants/textstyles.dart';

class CreateEventAddImageWidget extends StatelessWidget {
  const CreateEventAddImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0.h,
      width: 200.0.w,
      decoration: BoxDecoration(
        color: AppColors.imgContainerBlack,
        borderRadius: BorderRadius.circular(20.0.r),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.r),
            border: Border.all(width: 3.0.w, color: AppColors.exploreIconAsh),
          ),
          child: Text(
            "Add Photo",
            style: AppTextStyles.medium20.copyWith(
              color: AppColors.locationIconAsh,
            ),
          ),
        ),
      ),
    );
  }
}
