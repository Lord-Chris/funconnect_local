import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/models/_models.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(InitProfileEvent());
  }

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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, _) => previous is ProfileLoadingState,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const AppLoader(
              color: AppColors.primary,
            );
          }
          if (state is! ProfileIdleState) return const SizedBox();
          return BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (_, current) => current is ProfileIdleState,
            builder: (context, state) {
              if (state is! ProfileIdleState) return const SizedBox();
              UserModel userProfile = state.userProfile;
              return ScrollableColumn(
                padding: REdgeInsets.all(16),
                children: [
                  AppNetworkImage(
                    url: userProfile.photoUrl,
                    placeholderAssetImage: AppAssets.fallbackUserProfileSvg,
                    isCircular: true,
                    size: Size.fromRadius(54.r),
                    fit: BoxFit.cover,
                  ),
                  Spacing.vertMedium(),
                  Text(
                    userProfile.name,
                    style: AppTextStyles.medium20,
                  ),
                  Spacing.vertTiny(),
                  Spacing.vertSmall(),
                  Text(
                    userProfile.username,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.secondary500,
                    ),
                  ),
                  Spacing.vertTiny(),
                  Spacing.vertSmall(),
                  Text(
                    userProfile.email,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.secondary500,
                    ),
                  ),
                  Spacing.vertTiny(),
                  Spacing.vertSmall(),
                  Text(
                    userProfile.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.secondary200,
                    ),
                  ),
                  Spacing.vertTiny(),
                  Visibility(
                    visible: context
                            .watch<ProfileBloc>()
                            .location
                            ?.parsedAddress
                            .isEmpty ??
                        false,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.locationIconAsh,
                          size: 13,
                        ),
                        Flexible(
                          child: Text(
                            context
                                    .watch<ProfileBloc>()
                                    .location
                                    ?.parsedAddress ??
                                "",
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.secondary400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacing.vertExtraMedium(),
                  AppButton(
                    label: "Edit profile",
                    isCollapsed: true,
                    padding: REdgeInsets.fromLTRB(88, 19, 88, 19),
                    labelColor: AppColors.black,
                    onTap: () => context
                        .read<ProfileBloc>()
                        .add(EditProfileTapEvent(userProfile: userProfile)),
                  ),
                  Spacing.vertLarge(),
                  // _ProfileSubButton(
                  //   buttonColor: AppColors.secondary800,
                  //   label: "My Tickets",
                  //   onTap: () =>
                  //       context.read<ProfileBloc>().add(MyTicketTapEvent()),
                  // ),
                  // Spacing.vertRegular(),
                  _ProfileSubButton(
                    buttonColor: AppColors.primary.withOpacity(.2),
                    borderColor: AppColors.primary,
                    label: "My Events",
                    onTap: () =>
                        context.read<ProfileBloc>().add(MyEventTapEvent()),
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
                        // _buildProfileItems("Manage log-in options",
                        //     icon: const Icon(
                        //       Icons.arrow_forward_ios,
                        //       size: 15,
                        //     ),
                        //     onTap: () => context.read<ProfileBloc>().add(
                        //         ManageLoginOptionsTapEvent(
                        //             userProfile: userProfile))),
                        _buildProfileItems("Notifications",
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () => context
                                .read<ProfileBloc>()
                                .add(NotificationsTapEvent())),
                        // _buildProfileItems(
                        //   "Fingerprint/Face ID",
                        //   icon: AppSwitcher(
                        //     value: false,
                        //     onChanged: (val) {},
                        //   ),
                        // ),
                        // _buildProfileItems(
                        //   "Dark mode",
                        //   icon: AppSwitcher(
                        //     value: true,
                        //     onChanged: (val) {},
                        //   ),
                        // ),
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
                          onTap: () => context
                              .read<ProfileBloc>()
                              .add(HelpDeskTapEvent()),
                        ),
                        _buildProfileItems(
                          "Rate the app",
                          onTap: () => context.read<ProfileBloc>().add(
                              RateYourExperienceTapEvent(context: context)),
                        ),
                        // _buildProfileItems(
                        //   "Suggestions",
                        // ),
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
                            context.read<ProfileBloc>().appVersion == null
                                ? ""
                                : "v${context.watch<ProfileBloc>().appVersion}",
                            style: AppTextStyles.medium14.copyWith(
                              color: AppColors.secondary500,
                            ),
                          ),
                        ),
                        _buildProfileItems(
                          "Privacy",
                          onTap: () => context
                              .read<ProfileBloc>()
                              .add(PrivacyPolicyTapEvent()),
                        ),
                        _buildProfileItems(
                          "Terms of use",
                          onTap: () => context
                              .read<ProfileBloc>()
                              .add(TermsOfUseTapEvent()),
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
                      InkWell(
                        onTap: () => context
                            .read<ProfileBloc>()
                            .add(InstagramTapEvent()),
                        child: CircleAvatar(
                          radius: 26.5,
                          backgroundColor: AppColors.secondary800,
                          child: Image.asset(
                            AppAssets.instagramLogo,
                            scale: 2,
                          ),
                        ),
                      ),
                      Spacing.horizRegular(),
                      InkWell(
                        onTap: () =>
                            context.read<ProfileBloc>().add(TwitterTapEvent()),
                        child: CircleAvatar(
                          radius: 26.5,
                          backgroundColor: AppColors.secondary800,
                          child: SvgPicture.asset(AppAssets.twitterLogo),
                        ),
                      ),
                    ],
                  ),
                  Spacing.vertLarge(),
                  Spacing.vertMedium(),
                  AppButton(
                    label: AppText.aTLogOut,
                    isCollapsed: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 88, vertical: 16),
                    onTap: () =>
                        context.read<ProfileBloc>().add(LogoutTapEvent()),
                    labelColor: AppColors.black,
                  ),
                  Spacing.vertExtraMedium(),
                  InkWell(
                    onTap: () => context
                        .read<ProfileBloc>()
                        .add(DeleteTapAccountEvent()),
                    child: Text(
                      AppText.aTDeleteAccount,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.deleteTextRed,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
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
