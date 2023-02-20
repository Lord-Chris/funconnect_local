import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {

          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 11,
          ),
        ),
        title: Text(
          'Notification',
          style: AppTextStyles.medium24,
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Container(),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        separatorBuilder: (_, __) => Spacing.vertSmall(),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.notificationWidgetBlack,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 7.sp,
                  color: Random().nextBool() ? AppColors.green : AppColors.red,
                ),
                Spacing.horizSmall(),
                const AppNetworkImage(
                  url: AppConstants.mockImage,
                  isCircular: true,
                  fit: BoxFit.cover,
                  size: Size.fromRadius(18),
                ),
                Spacing.horizRegular(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "System update! ",
                                style: AppTextStyles.regular12),
                            TextSpan(
                              text:
                                  "We've added new recreational centres to the best for you section.",
                              style: AppTextStyles.regular12.copyWith(
                                color: AppColors.gray97,
                              ),
                            ),
                            TextSpan(
                              text: " Check them out!",
                              style: AppTextStyles.medium12.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacing.vertExtraTiny(),
                      Text(
                        "23mins ago",
                        style: AppTextStyles.dynamic(
                          9,
                          weight: FontWeight.w300,
                          color: AppColors.gray97,
                        ),
                      )
                    ],
                  ),
                ),
                Spacing.horizRegular(),
                AppButton(
                  label: "Book now",
                  isCollapsed: true,
                  labelColor: AppColors.black,
                  labelSize: 10.sm,
                  fontWeight: FontWeight.w500,
                  borderRadius: 6,
                  padding: REdgeInsets.fromLTRB(8, 4, 8, 4),
                  height: 24,
                  width: 54,
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
