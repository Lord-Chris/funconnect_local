import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/profile/presentation/blocs/manage_login_options_bloc/manage_login_options_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/models/_models.dart';

class ManageLogInOptionsView extends StatelessWidget {
  const ManageLogInOptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ManageLoginOptionsBloc>().add(BackTapEvent());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            onPressed: () =>
                context.read<ManageLoginOptionsBloc>().add(BackTapEvent()),
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
        body: BlocBuilder<ManageLoginOptionsBloc, ManageLoginOptionsState>(
          builder: (context, state) {
            UserModel userProfile = state.profile;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    Spacing.vertLarge(),
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
                    Spacing.vertRegular(),
                    Text(
                      userProfile.email,
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
                      label: AppText.aTLogOut,
                      isCollapsed: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 88, vertical: 16),
                      onTap: () => context
                          .read<ManageLoginOptionsBloc>()
                          .add(LogoutTapEvent()),
                      labelColor: AppColors.black,
                    ),
                    Spacing.vertExtraMedium(),
                    InkWell(
                      onTap: () => context
                          .read<ManageLoginOptionsBloc>()
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
              ),
            );
          },
        ),
      ),
    );
  }
}
