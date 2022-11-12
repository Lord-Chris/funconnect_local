import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/presentation/widgets/app_auth_text_form_field.dart';
import '../../../../core/presentation/widgets/app_black_modal.dart';
import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../../../shared/constants/app_textStyle.dart';

class ProfileSetUpView extends StatefulWidget {
  const ProfileSetUpView({Key? key}) : super(key: key);

  @override
  State<ProfileSetUpView> createState() => _ProfileSetUpViewState();
}

class _ProfileSetUpViewState extends State<ProfileSetUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBlackModalWidget(
        modalHeight: MediaQuery.of(context).size.height,
        children: [
          Text("Profile setup",
              style: AppTextStyle.WhiteBold.copyWith(fontSize: 24.0)),
          const SizedBox(height: 8.0),
          Text(
              "We would like to know about you Please kindly\nset up your profile.",
              textAlign: TextAlign.center,
              style: AppTextStyle.WhiteMedium),
          const SizedBox(height: 29),
          CircleAvatar(
            radius: 70.0,
            backgroundColor: AppColors.lightAsh,
            child: Center(
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 50,
                  )),
            ),
          ),
          const SizedBox(height: 8.0),
          Text("Add image",
              textAlign: TextAlign.center, style: AppTextStyle.WhiteMedium),
          const SizedBox(height: 29),
          Form(
              child: Column(
            children: [
              AppTextForm(
                prefixIcon: const Icon(
                  Icons.person,
                  color: AppColors.ash,
                ),
                hintText: "Full name",
                onChanged: (String) {},
                validator: (String) {},
              ),
              AppTextForm(
                prefixIcon: const Icon(
                  Icons.person,
                  color: AppColors.ash,
                ),
                hintText: "Username",
                onChanged: (String) {},
                validator: (String) {},
              ),
              AppTextForm(
                prefixIcon: const Icon(
                  Icons.person,
                  color: AppColors.ash,
                ),
                hintText: "Gender",
                onChanged: (String) {},
                validator: (String) {},
              ),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.locationIconAsh,
              ),
              Text("Share my location",
                  textAlign: TextAlign.center, style: AppTextStyle.WhiteMedium),
            ],
          ),
          const SizedBox(height: 62),
          App_Orange_Btn(
            label: "Continue",
          ),
        ],
      ),
    );
  }
}
