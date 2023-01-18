import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/presentation/widgets/core_widgets.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/components/scrollable_column.dart';
import 'package:funconnect/shared/constants/app_assets.dart';
import 'package:funconnect/shared/constants/app_constants.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Profile",
          style: AppTextStyles.medium28,
        ),
      ),
      body: ScrollableColumn(
        padding: REdgeInsets.all(16),
        children: [
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
          Spacing.vertTiny(),
          Spacing.vertSmall(),
          Text(
            "@johndoe066",
            style: AppTextStyles.regular16.copyWith(
              color: AppColors.secondary500,
            ),
          ),
          Spacing.vertTiny(),
          Spacing.vertSmall(),
          Text(
            "johndoe@gmail.com",
            style: AppTextStyles.regular16.copyWith(
              color: AppColors.secondary500,
            ),
          ),
          Spacing.vertTiny(),
          Spacing.vertSmall(),
          Text(
            "I know that no single approach is the...",
            style: AppTextStyles.regular16.copyWith(
              color: AppColors.secondary200,
            ),
          ),
          Spacing.vertTiny(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.secondary500,
                size: 18,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  "Lagos, Nigeria",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.secondary500,
                  ),
                ),
              ),
            ],
          ),
          Spacing.vertExtraMedium(),
          AppButton(
            label: "Edit profile",
            isCollapsed: true,
            padding: REdgeInsets.fromLTRB(88, 19, 88, 19),
            labelColor: AppColors.black,
            onTap: () {},
          ),
          Spacing.vertLarge(),
          _ProfileSubButton(
            buttonColor: AppColors.secondary800,
            label: "My Tickets",
            onTap: () {},
          ),
          Spacing.vertRegular(),
          _ProfileSubButton(
            buttonColor: AppColors.primary.withOpacity(.2),
            borderColor: AppColors.primary,
            label: "My Events",
            onTap: () {},
          ),
          Spacing.vertRegular(),
          Container(
            padding: REdgeInsets.fromLTRB(18, 22, 18, 20),
            decoration: BoxDecoration(
              color: AppColors.secondary800,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: AppTextStyles.semiBold20,
                ),
                _buildProfileItems(
                  "Manage log-in options",
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
                _buildProfileItems(
                  "Notifications",
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
                _buildProfileItems(
                  "Fingerprint/Face ID",
                  icon: AppSwitcher(
                    value: false,
                    onChanged: (val) {},
                  ),
                ),
                _buildProfileItems(
                  "Dark mode",
                  icon: AppSwitcher(
                    value: true,
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
          ),
          Spacing.vertRegular(),
          Container(
            padding: REdgeInsets.fromLTRB(18, 22, 18, 20),
            decoration: BoxDecoration(
              color: AppColors.secondary800,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Support",
                  style: AppTextStyles.semiBold20,
                ),
                _buildProfileItems(
                  "Help desk",
                ),
                _buildProfileItems(
                  "Rate the app",
                ),
                _buildProfileItems(
                  "Suggestions",
                ),
              ],
            ),
          ),
          Spacing.vertRegular(),
          Container(
            padding: REdgeInsets.fromLTRB(18, 22, 18, 20),
            decoration: BoxDecoration(
              color: AppColors.secondary800,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: AppTextStyles.semiBold20,
                ),
                _buildProfileItems(
                  "Version",
                  icon: Text(
                    "v1.0",
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.secondary500,
                    ),
                  ),
                ),
                _buildProfileItems(
                  "Privacy",
                ),
                _buildProfileItems(
                  "Terms of use",
                ),
              ],
            ),
          ),
          Spacing.vertLarge(),
          Text(
            "Connect with us",
            style: AppTextStyles.medium20,
          ),
          Spacing.vertMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26.5,
                backgroundColor: AppColors.secondary800,
                child: Image.asset(
                  AppAssets.telegramLogo,
                  scale: 2,
                ),
              ),
              Spacing.horizRegular(),
              CircleAvatar(
                radius: 26.5,
                backgroundColor: AppColors.secondary800,
                child: Image.asset(
                  AppAssets.instagramLogo,
                  scale: 2,
                ),
              ),
              Spacing.horizRegular(),
              CircleAvatar(
                radius: 26.5,
                backgroundColor: AppColors.secondary800,
                child: SvgPicture.asset(AppAssets.twitterLogo),
              ),
            ],
          ),
          Spacing.vertLarge(),
          Spacing.vertMedium(),
          AppButton(
            label: "Log out",
            isCollapsed: true,
            padding: REdgeInsets.fromLTRB(88, 19, 88, 19),
            labelColor: AppColors.black,
            onTap: () {},
          ),
          Spacing.vertExtraMedium(),
          Text(
            "Delete account",
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileItems(
    String title, {
    Widget? icon,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.regular16,
            ),
            icon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _ProfileSubButton extends StatelessWidget {
  final Color buttonColor;
  final Color? borderColor;
  final String label;
  final VoidCallback onTap;
  const _ProfileSubButton({
    Key? key,
    required this.buttonColor,
    this.borderColor,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.all(18),
        decoration: BoxDecoration(
          border: borderColor == null
              ? null
              : Border.all(
                  color: borderColor!,
                  width: .5,
                ),
          color: buttonColor,
          borderRadius: BorderRadius.circular(54),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.regular16,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
