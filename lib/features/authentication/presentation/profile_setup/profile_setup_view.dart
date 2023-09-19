import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/models/user_model.dart';
import 'package:funconnect/features/authentication/presentation/profile_setup/bloc/profile_setup_bloc.dart';
import 'package:funconnect/features/authentication/presentation/profile_setup/bloc/profile_setup_event.dart';
import 'package:funconnect/features/authentication/presentation/profile_setup/bloc/profile_setup_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/components/_components.dart';
import '../../../../shared/components/app_black_modal.dart';

class ProfileSetUpView extends HookWidget {
  final UserModel user;
  ProfileSetUpView({
    super.key,
    required this.user,
  });
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final usernameController = useTextEditingController();
    final gender = useState<String?>(null);
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
            builder: (context, state) {
          return Form(
            key: formKey,
            child: AppBlackModalWidget(
              showBackButton: true,
              modalHeight: MediaQuery.of(context).size.height,
              topIcon: SvgPicture.asset(
                AppAssets.profIconSvg,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onBackground,
                    BlendMode.srcIn),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Profile setup",
                        style: AppTextStyles.medium24.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We would like to know about you Please kindly\nset up your profile.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.light14.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 29),
                      DottedBorder(
                        borderType: BorderType.Circle,
                        padding: const EdgeInsets.all(8),
                        color:
                            isDarkMode ? AppColors.lightAsh : AppColors.wGreyF8,
                        dashPattern: const [8, 6],
                        strokeWidth: 1.6,
                        strokeCap: StrokeCap.round,
                        child: GestureDetector(
                          onTap: () => context
                              .read<ProfileSetupBloc>()
                              .add(AddImageEvent()),
                          child:
                              BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
                            buildWhen: (_, current) =>
                                current is ProfileSetupIdleState,
                            builder: (context, state) {
                              if (state is! ProfileSetupIdleState ||
                                  state.image == null) {
                                return CircleAvatar(
                                  radius: 55,
                                  backgroundColor: isDarkMode
                                      ? AppColors.lightAsh
                                      : AppColors.wGreyF8,
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: isDarkMode
                                          ? AppColors.black
                                          : AppColors.gray1,
                                    ),
                                  ),
                                );
                              }
                              return CircleAvatar(
                                radius: 55,
                                backgroundColor: isDarkMode
                                    ? AppColors.lightAsh
                                    : AppColors.wGreyF8,
                                backgroundImage: FileImage(state.image!),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Add image",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.light14.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 29),
                      Column(
                        children: [
                          AppTextField(
                            prefix: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: SvgPicture.asset(AppAssets.profileIconSvg),
                            ),
                            label: "Full name",
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            textCapitalization: TextCapitalization.words,
                            maxLines: 1,
                            validator: context.validateFullName,
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            prefix: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: SvgPicture.asset(AppAssets.profileIconSvg),
                            ),
                            label: "Username",
                            controller: usernameController,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(" "),
                            ],
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.none,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            validator: context.validateNotEmpty,
                          ),
                          const SizedBox(height: 20),
                          AppDropdownField<String>(
                            label: "Gender",
                            items: const ["Male", "Female"],
                            value: gender.value,
                            onChanged: (val) => gender.value = val,
                            validator: context.validateNotEmpty,
                            prefix: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: SvgPicture.asset(AppAssets.profileIconSvg),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.locationIconAsh,
                            size: 20,
                          ),
                          TextButton(
                            onPressed: () => context
                                .read<ProfileSetupBloc>()
                                .add(ShareLocationEvent()),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              "Share my location",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.regular14.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppButton(
                    label: "Continue",
                    isBusy: state is ProfileSetupLoadingState,
                    borderRadius: 8,
                    height: 65,
                    labelSize: 20,
                    onTap: () {
                      if (!formKey.currentState!.validate()) return;
                      context.read<ProfileSetupBloc>().add(SetupProfileEvent(
                            fullName: nameController.text,
                            username: usernameController.text,
                            gender: gender.value!,
                          ));
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
