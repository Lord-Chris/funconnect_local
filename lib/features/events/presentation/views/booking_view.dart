import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/presentation/widgets/core_widgets.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:funconnect/shared/constants/app_constants.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        leading: const BackButton(color: AppColors.white),
        title: Text(
          "Booking",
          style: AppTextStyles.medium24,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.secondary200.withOpacity(.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.secondary500,
                  width: 0.7,
                ),
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        child: Text(
                          "October 15th, 2022 11:00 AM - 2:00 PM WAT",
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.gray97,
                          ),
                        ),
                      ),
                      Spacing.vertRegular(),
                      Text(
                        "Food is Art (The art of food photography + Street food fair)",
                        style: AppTextStyles.semiBold20,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Visitors ticket",
                                  style: AppTextStyles.regular16,
                                ),
                                Spacing.vertSmall(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding:
                                          REdgeInsets.fromLTRB(10, 4, 10, 4),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0.r),
                                        color: AppColors.secondary700,
                                      ),
                                      child: Text(
                                        "Free",
                                        style: AppTextStyles.regular14.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    Spacing.horizSmall(),
                                    Text(
                                      "NGN 0.00",
                                      style: AppTextStyles.regular16.copyWith(
                                        color: AppColors.secondary500,
                                        height: 1,
                                      ),
                                    )
                                  ],
                                ),
                                Spacing.vertSmall(),
                                Text(
                                  "Booking ends Oct 13, 2022",
                                  style: AppTextStyles.regular14.copyWith(
                                    color: AppColors.gray97,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownButton<int>(
                            items: [
                              for (int i = 1; i < 10; i++)
                                DropdownMenuItem<int>(
                                  value: i,
                                  child: Text(
                                    i.toString(),
                                    style: AppTextStyles.regular12,
                                  ),
                                )
                            ],
                            onChanged: (val) {},
                            value: 2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacing.vertRegular(),
                  const Divider(),
                  Spacing.vertRegular(),
                  const Expanded(
                    child: AppNetworkImage(
                      url: AppConstants.mockImage,
                      borderRadius: 5,
                      fit: BoxFit.cover,
                      size: Size.fromHeight(200),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  "Free",
                  style: AppTextStyles.regular20.copyWith(
                    color: AppColors.gray97,
                  ),
                ),
                Spacing.horizRegular(),
                Expanded(
                  child: AppButton(
                    label: "Request",
                    buttonColor: AppColors.primary,
                    labelColor: AppColors.black,
                    labelSize: 14,
                    onTap: () => locator<INavigationService>()
                        .toNamed(Routes.checkoutRoute),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
