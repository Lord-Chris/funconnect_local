import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/app_constants.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class ManageLogInOptionsView extends StatelessWidget {
  const ManageLogInOptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
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
          AppText.aTLoginOptions,
          style: AppTextStyles.medium24,
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Container(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            children: [
              Spacing.vertLarge(),
              AppNetworkImage(
                url: AppConstants.mockImage,
                isCircular: true,
                size: Size.fromRadius(54.r),
                fit: BoxFit.cover,
              ),
              Spacing.vertMedium(),
              Text(
                "John Doe",
                style: AppTextStyles.medium20,
              ),
              Spacing.vertRegular(),
              Text(
                "@johndoe@gmail.com",
                style: AppTextStyles.regular16.copyWith(
                  color: AppColors.secondary500,
                ),
              ),
              Spacing.vertExtraExtraLarge(),
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.imgContainerBlack,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.mail,
                      height: 10,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Spacing.horizMedium(),
                  Text(
                    AppText.aTLoginWithEmail,
                    style: AppTextStyles.regular16,
                  ),
                  const Spacer(),
                  AppSwitcher(
                    value: true,
                    onChanged: (val) {},
                  ),
                ],
              ),
              Spacing.vertExtraMedium(),
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.imgContainerBlack,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.appleSvg,
                      height: 10,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Spacing.horizMedium(),
                  Text(
                    AppText.aTLoginWithApple,
                    style: AppTextStyles.regular16,
                  ),
                  const Spacer(),
                  AppSwitcher(
                    value: false,
                    onChanged: (val) {},
                  ),
                ],
              ),
              Spacing.vertExtraMedium(),
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.imgContainerBlack,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.googleSvg,
                      height: 10,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Spacing.horizMedium(),
                  Text(
                    AppText.aTLoginWithGoogle,
                    style: AppTextStyles.regular16,
                  ),
                  const Spacer(),
                  AppSwitcher(
                    value: false,
                    onChanged: (val) {},
                  ),
                ],
              ),
              Spacing.vertExtraMedium(),
              AppButton(
                label: 'Log out',
                isCollapsed: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 88, vertical: 16),
                onTap: () {},
                labelColor: AppColors.black,
              ),
              Spacing.vertExtraMedium(),
              Text(
                "Delete account",
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.deleteTextRed,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
