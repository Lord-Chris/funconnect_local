import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/blocs/bloc/theme_switcher_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/models/_models.dart';
import 'bloc/profile_bloc.dart';

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
      appBar: AppBar(
        toolbarHeight: 56,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Profile",
          style: AppTextStyles.medium28
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const AppLoader(
              color: AppColors.primary,
            );
          }
          if (state is ProfileFailureState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.failure.message,
                      style: AppTextStyles.medium14.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Spacing.vertRegular(),
                    AppButton(
                      label: "Retry",
                      isCollapsed: true,
                      labelColor: AppColors.black,
                      onTap: () => context
                          .read<ProfileBloc>()
                          .add(InitProfileEvent(false)),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is! ProfileIdleState) return const SizedBox();
          return BlocBuilder<ProfileBloc, ProfileState>(
            // buildWhen: (_, current) => current is ProfileIdleState,
            builder: (context, state) {
              if (state is! ProfileIdleState) return const SizedBox();
              UserModel userProfile = state.userProfile;
              return RefreshIndicator(
                onRefresh: () async {
                  final bloc = context.read<ProfileBloc>().stream.first;
                  context.read<ProfileBloc>().add(InitProfileEvent(false));
                  await bloc;
                },
                child: ScrollableColumn(
                  padding: REdgeInsets.all(16),
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppNetworkImage(
                          url: userProfile.photoUrl,
                          placeholderAssetImage:
                              AppAssets.fallbackUserProfileSvg,
                          isCircular: true,
                          cacheImage: false,
                          size: Size.fromRadius(37.r),
                          fit: BoxFit.cover,
                        ),
                        Spacing.horizRegular(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      userProfile.name,
                                      style: AppTextStyles.medium20.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        context.watch<ProfileBloc>().location !=
                                            null,
                                    child: Container(
                                      padding: REdgeInsets.fromLTRB(7, 5, 7, 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.secondary700,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? AppColors.white
                                                    : AppColors.black,
                                            size: 13,
                                          ),
                                          Spacing.horizExtraTiny(),
                                          Flexible(
                                            child: Text(
                                              context
                                                      .watch<ProfileBloc>()
                                                      .location
                                                      ?.city ??
                                                  '',
                                              style: AppTextStyles.regular10
                                                  .copyWith(
                                                color: AppColors.secondary400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacing.vertTiny(),
                              Text(
                                '@${userProfile.username}',
                                style: AppTextStyles.regular14.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.secondary500
                                      : AppColors.gray333,
                                ),
                              ),
                              Spacing.vertTiny(),
                              Text(
                                userProfile.email,
                                style: AppTextStyles.regular14.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.secondary500
                                      : AppColors.gray333,
                                ),
                              ),
                              if (userProfile.bio.isNotEmpty) ...[
                                Spacing.vertSmall(),
                                Text(
                                  userProfile.bio,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.regular14.copyWith(
                                    color: AppColors.secondary200,
                                  ),
                                ),
                              ],
                              Spacing.vertRegular(),
                              AppButton(
                                label: "Edit profile",
                                isCollapsed: true,
                                hasBorder: true,
                                borderRadius: 8,
                                padding: REdgeInsets.fromLTRB(32, 5, 32, 5),
                                labelColor:
                                    Theme.of(context).colorScheme.onBackground,
                                borderColor: AppColors.info700,
                                buttonColor: AppColors.transparent,
                                onTap: () => context.read<ProfileBloc>().add(
                                    EditProfileTapEvent(
                                        userProfile: userProfile)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacing.vertMedium(),
                    const Divider(color: AppColors.ash),
                    Spacing.vertMedium(),
                    // _ProfileSubButton(
                    //   buttonColor: AppColors.secondary800,
                    //   label: "My Tickets",
                    //   onTap: () =>
                    //       context.read<ProfileBloc>().add(MyTicketTapEvent()),
                    // ),
                    // Spacing.vertRegular(),
                    if (!Platform.isIOS) ...[
                      _ProfileSubButton(
                        buttonColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.primary.withOpacity(.2)
                                : const Color(0xffffc16f),
                        borderColor: AppColors.primary,
                        label: "My Events",
                        onTap: () =>
                            context.read<ProfileBloc>().add(MyEventTapEvent()),
                      ),
                      Spacing.vertRegular(),
                    ],
                    Container(
                      padding: REdgeInsets.fromLTRB(18, 22, 18, 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.secondary800
                            : AppColors.wGreyF1,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Settings",
                            style: AppTextStyles.semiBold20.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          // _buildProfileItems(
                          //   "Manage log-in options",
                          //   icon: const Icon(
                          //     Icons.arrow_forward_ios,
                          //     size: 15,
                          //   ),
                          //   onTap: () => context
                          //       .read<ProfileBloc>()
                          //       .add(ManageLoginOptionsTapEvent(
                          //         userProfile: userProfile,
                          //       )),
                          // ),
                          _buildProfileItems(
                            "Notifications",
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            onTap: () => context
                                .read<ProfileBloc>()
                                .add(NotificationsTapEvent()),
                          ),
                          // _buildProfileItems(
                          //   "Fingerprint/Face ID",
                          //   icon: AppSwitcher(
                          //     value: false,
                          //     onChanged: (val) {},
                          //   ),
                          // ),
                          BlocBuilder<ThemeSwitcherBloc, ThemeData>(
                            builder: (context, state) {
                              return _buildProfileItems("Dark mode",
                                  icon: AppSwitcher(
                                    value: state.brightness == Brightness.dark,
                                    onChanged: (val) {
                                      BlocProvider.of<ThemeSwitcherBloc>(
                                              context)
                                          .add(ThemeSwitcherEventToggle());
                                    },
                                  ));
                            },
                          )
                        ],
                      ),
                    ),
                    Spacing.vertRegular(),
                    Container(
                      padding: REdgeInsets.fromLTRB(18, 22, 18, 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.secondary800
                            : AppColors.wGreyF1,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Support",
                            style: AppTextStyles.semiBold20.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.secondary800
                            : AppColors.wGreyF1,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            style: AppTextStyles.semiBold20.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
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
                    Text("Connect with us",
                        style: AppTextStyles.medium20.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
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
                          onTap: () => context
                              .read<ProfileBloc>()
                              .add(TwitterTapEvent()),
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
                ),
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
              style: AppTextStyles.regular16.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
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
              style: AppTextStyles.regular16
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
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
