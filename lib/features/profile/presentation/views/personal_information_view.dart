import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';

import '../../../../core/models/_models.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        UserModel profile = state.profile;
        String iFullName = profile.name != 'null' ? profile.name : '';
        String iUserName = profile.username != 'null' ? profile.username : '';
        String iEmail = profile.email != 'null' ? profile.email : '';
        String? selectedGender = profile.gender.isEmpty
            ? null
            : '${profile.gender[0].toUpperCase()}${profile.gender.substring(1).toLowerCase()}';
        String iDateOfBirth = profile.dob.isEmpty
            ? ""
            : DateFormat('dd/MM/yyyy').format(DateTime.parse(profile.dob));
        String iMobileNumber =
            profile.phoneE164.isEmpty || profile.phoneE164 == 'null'
                ? ""
                : "+${profile.phoneE164}";
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  AppText.aTPersonalInformation,
                  style: AppTextStyles.medium20,
                ),
                Spacing.vertLarge(),
                DottedBorder(
                  borderType: BorderType.Circle,
                  padding: const EdgeInsets.all(8),
                  color: AppColors.lightAsh,
                  dashPattern: const [8, 6],
                  strokeWidth: 1.6,
                  strokeCap: StrokeCap.round,
                  child: InkWell(
                    onTap: () =>
                        context.read<EditProfileBloc>().add(ImageTapEvent()),
                    child: Container(
                      height: 180.w,
                      width: 180.w,
                      decoration: const BoxDecoration(
                        color: AppColors.lightAsh,
                        shape: BoxShape.circle,
                      ),
                      child: profile.photoUrl.isEmpty
                          ? Center(
                              child: SvgPicture.asset(
                              AppAssets.addImageCamera,
                              height: 64,
                            ))
                          : profile.photoUrl.startsWith("http")
                              ? ClipOval(
                                  child: AppNetworkImage(
                                    url: profile.photoUrl,
                                    size: const Size.fromRadius(32),
                                    isCircular: true,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(profile.photoUrl),
                                  ),
                                ),
                    ),
                  ),
                ),
                Spacing.vertLarge(),
                AppTextField(
                  onChanged: (val) => context
                      .read<EditProfileBloc>()
                      .add(EditProfileFieldsEvent(profile.copyWith(name: val))),
                  validator: context.validateFullName,
                  initialValue: iFullName,
                  autovalidateMode: state.autoValidateForm
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  label: AppText.aTFullName,
                  hint: AppText.aTFullName,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.userProfile,
                      height: 17.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Spacing.vertMedium(),
                AppTextField(
                  onChanged: (val) => context.read<EditProfileBloc>().add(
                      EditProfileFieldsEvent(profile.copyWith(username: val))),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                  ],
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.none,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  validator: context.validateNotEmpty,
                  autovalidateMode: state.autoValidateForm
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  label: AppText.aTUserName,
                  hint: AppText.aTUserName,
                  initialValue: iUserName,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.userProfile,
                      height: 17.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Spacing.vertMedium(),
                AppTextField(
                  onChanged: (val) => context.read<EditProfileBloc>().add(
                      EditProfileFieldsEvent(profile.copyWith(email: val))),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                  ],
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  validator: context.validateEmail,
                  autovalidateMode: state.autoValidateForm
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  initialValue: iEmail,
                  label: AppText.aTEmail,
                  hint: AppText.aTEmail,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.mail,
                      height: 17.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Spacing.vertMedium(),
                AppDropdownField<String>(
                  label: "Gender",
                  items: const ["Male", "Female"],
                  prefix: SvgPicture.asset(
                    AppAssets.userProfile,
                    height: 17.h,
                    fit: BoxFit.scaleDown,
                  ),
                  validator: context.validateGender,
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.arrowDown,
                      width: 10,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  onChanged: (val) => context.read<EditProfileBloc>().add(
                      EditProfileFieldsEvent(profile.copyWith(gender: val))),
                  value: selectedGender,
                ),
                Spacing.vertMedium(),
                AppTextField(
                  controller: TextEditingController(text: iDateOfBirth),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                  ],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  validator: context.validateNotEmpty,
                  autovalidateMode: state.autoValidateForm
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? dateOfBirth = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime.now());
                    if (dateOfBirth != null) {
                      // ignore: use_build_context_synchronously
                      context.read<EditProfileBloc>().add(
                          EditProfileFieldsEvent(profile.copyWith(
                              dob: dateOfBirth.toIso8601String())));
                    }
                  },
                  label: AppText.aTDateOfBirth,
                  hint: AppText.aTDateOfBirthHint,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.calendar,
                      height: 17.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  suffix: SvgPicture.asset(
                    AppAssets.arrowDown,
                    width: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Spacing.vertMedium(),
                FutureBuilder(
                  future:
                      PhoneNumber.getRegionInfoFromPhoneNumber(iMobileNumber)
                          .catchError((error) {
                    return PhoneNumber(isoCode: 'NG', dialCode: '+253');
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return InternationalPhoneNumberInput(
                        onInputChanged: (val) {
                          context.read<EditProfileBloc>().add(
                              EditProfileFieldsEvent(profile.copyWith(
                                  phoneE164: val.phoneNumber)));
                        },
                        onInputValidated: (value) {
                          context
                              .read<EditProfileBloc>()
                              .add(NumberValidationEvent(value));
                        },
                        initialValue: snapshot.data,
                        inputDecoration: InputDecoration(
                          labelText: AppText.aTMobileNumber,
                          suffixIcon: SvgPicture.asset(
                            AppAssets.arrowDown,
                            width: 20,
                            fit: BoxFit.scaleDown,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              AppAssets.phone,
                              height: 17.h,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle: AppTextStyles.regular14.copyWith(
                            color: AppColors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.gray333,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.gray333,
                              width: 1,
                            ),
                          ),
                          labelStyle: AppTextStyles.regular14.copyWith(
                            color: AppColors.white,
                          ),
                          hintStyle: AppTextStyles.regular14.copyWith(
                            color: AppColors.gray333,
                            fontWeight: FontWeight.w300,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.gray333,
                              width: 1,
                            ),
                          ),
                        ),
                        autoValidateMode: AutovalidateMode.onUserInteraction);
                  },
                ),
                Spacing.vertMedium(),
                /*
                AppTextField(
                  onChanged: (val) {

                    context.read<EditProfileBloc>().add(EditProfileFieldsEvent(
                        profile.copyWith(phoneE164: val)));
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                  ],
                  initialValue: iMobileNumber,
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  validator: context.validatePhoneNumber,
                  autovalidateMode: state.autoValidateForm
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  label: AppText.aTMobileNumber,
                  hint: AppText.aTMobileNumberHint,
                  suffix: SvgPicture.asset(
                    AppAssets.arrowDown,
                    width: 20,
                    fit: BoxFit.scaleDown,
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.phone,
                      height: 17.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                */

                Spacing.vertLarge(),
                Align(
                    alignment: Alignment.centerRight,
                    child: AppButton(
                      onTap: () {
                        if (!formKey.currentState!.validate()) {
                          context
                              .read<EditProfileBloc>()
                              .add(AutoValidateFormEvent());
                        } else {
                          if (context.read<EditProfileBloc>().isNumberValid) {
                            context
                                .read<EditProfileBloc>()
                                .add(ContinueTapEvent());
                          } else {
                            Logger().d("Number not valid");
                          }
                        }
                      },
                      label: AppText.aTContinue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      suffixWidget: SvgPicture.asset(
                        AppAssets.arrowRight,
                        width: 17,
                        fit: BoxFit.scaleDown,
                      ),
                      isCollapsed: true,
                      labelColor: AppColors.black,
                    )),
                Spacing.vertRegular(),
                Spacing.vertLarge(),
              ],
            ),
          ),
        );
      },
    );
  }
}
