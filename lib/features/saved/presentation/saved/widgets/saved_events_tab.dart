import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/components/_components.dart';
import '../../../../../shared/constants/_constants.dart';

class SavedEventsTab extends StatelessWidget {
  const SavedEventsTab({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            AppAssets.eventIconSvg,
            height: 80.sp,
          ),
          Spacing.vertExtraMedium(),
          Text(
            "Saved Events!",
            textAlign: TextAlign.center,
            style: AppTextStyles.regular20,
          ),
          Spacing.vertLarge(),
          Spacing.vertRegular(),
          Text(
            "Coming Soon!",
            textAlign: TextAlign.center,
            style: AppTextStyles.medium28,
          ),
          Spacing.vertRegular(),
          Flexible(
            child: Text(
              "You will recieve a notification\nwhen we launch.",
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertLarge(),
          Center(
            child: AppButton(
              label: 'Saved Places',
              labelColor: AppColors.black,
              isCollapsed: true,
              padding: REdgeInsets.fromLTRB(50, 17, 50, 17),
              prefixWidget: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 20.sp,
              ),
              onTap: () => _tabController.animateTo(0),
            ),
          ),
        ],
      ),
    );
  }
}
