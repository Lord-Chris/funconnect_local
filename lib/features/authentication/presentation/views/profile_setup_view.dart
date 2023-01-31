import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_state.dart';
import 'package:funconnect/shared/components/text_input.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../widgets/app_black_modal.dart';

class ProfileSetUpView extends HookWidget {
  ProfileSetUpView({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final usernameController = useTextEditingController();
    final gender = useState<String?>(null);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocProvider<ProfileSetupBloc>(
          create: (context) => ProfileSetupBloc(),
          child: BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
              builder: (context, state) {
            return Form(
              key: formKey,
              child: AppBlackModalWidget(
                showBackButton: true,
                modalHeight: MediaQuery.of(context).size.height,
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
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "We would like to know about you Please kindly\nset up your profile.",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.light14.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 29),
                        GestureDetector(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 58.0,
                            backgroundColor: AppColors.lightAsh,
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Add image",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.light14.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 29),
                        Column(
                          children: [
                            AppTextField(
                              prefix: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child:
                                    SvgPicture.asset(AppAssets.profileIconSvg),
                              ),
                              label: "Full name",
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              maxLines: 1,
                              validator: context.validateFullName,
                            ),
                            const SizedBox(height: 20),
                            AppTextField(
                              prefix: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child:
                                    SvgPicture.asset(AppAssets.profileIconSvg),
                              ),
                              label: "Username",
                              controller: usernameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(" "),
                              ],
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.none,
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
                                child:
                                    SvgPicture.asset(AppAssets.profileIconSvg),
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
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  AppOrangeBtn(
                    label: "Continue",
                    isBusy: state is ProfileSetupLoadingState,
                    onTap: () {
                      if (!formKey.currentState!.validate()) return;
                      context.read<ProfileSetupBloc>().add(SetupProfileEvent(
                            fullName: nameController.text,
                            username: usernameController.text,
                            gender: gender.value!,
                          ));
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
