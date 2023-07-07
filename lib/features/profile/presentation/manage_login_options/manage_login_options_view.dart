import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/models/_models.dart';
import 'bloc/manage_login_options_bloc.dart';

class ManageLogInOptionsView extends HookWidget {
  const ManageLogInOptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<ManageLoginOptionsBloc>().add(ManageLoginInitEvent());
      return null;
    }, []);
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
                    _buildOption(
                      AppAssets.mail,
                      AppText.aTLoginWithEmail,
                      state.loginOptionsData.authWithEmail,
                      (val) => context
                          .read<ManageLoginOptionsBloc>()
                          .add(ToggleEmailLogInEvent(val)),
                    ),
                    Spacing.vertExtraMedium(),
                    _buildOption(
                      AppAssets.appleSvg,
                      AppText.aTLoginWithApple,
                      state.loginOptionsData.authWithApple,
                      (val) => context
                          .read<ManageLoginOptionsBloc>()
                          .add(ToggleAppleLogInEvent(val)),
                    ),
                    Spacing.vertExtraMedium(),
                    _buildOption(
                      AppAssets.googleSvg,
                      AppText.aTLoginWithGoogle,
                      state.loginOptionsData.authWithGoogle,
                      (val) => context
                          .read<ManageLoginOptionsBloc>()
                          .add(ToggleGoogleLogInEvent(val)),
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

  Row _buildOption(
    String icon,
    String label,
    bool value,
    void Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: const BoxDecoration(
            color: AppColors.imgContainerBlack,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            height: 10,
            fit: BoxFit.scaleDown,
          ),
        ),
        Spacing.horizMedium(),
        Text(
          label,
          style: AppTextStyles.regular16,
        ),
        const Spacer(),
        AppSwitcher(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
