import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/fun_connect/event/presentation/widgets/create_event_add_image_widget.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../shared/components/custom_button.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.white,
          size: 14,
        ),
        title: Text(
          AppText.aTCreateEventAppBarText,
          style: AppTextStyles.whiteMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            children: [
              AppSpacer.xtraHeightSpace,
              const Center(
                child: CreateEventAddImageWidget(),
              ),
              AppSpacer.xtraHeightSpace,
              AppTextForm(
                onChanged: (String) {},
                validator: (String) {
                  return null;
                },
                labelText: AppText.aTCreateEventTextFormTitleText,
                hintText: AppText.aTCreateEventTextFormSubTitleText,
              ),
              AppSpacer.xtraHeightSpace,
              AppTextForm(
                onChanged: (String) {},
                validator: (String) {
                  return null;
                },
                labelText: AppText.aTCreateEventDiscriptionFormText,
                hintText: AppText.aTCreateEventDiscriptionFormSubText,
                maxLines: 5,
              ),
              AppSpacer.xtraHeightSpace,
              Row(
                children: [
                  SizedBox(
                    width: 190.w,
                    child: AppTextForm(
                      onChanged: (String) {},
                      validator: (String) {
                        return null;
                      },
                      labelText: "Date",
                      hintText: "DD/MM/YYYY",
                    ),
                  ),
                  AppSpacer.xtraWeightSpace,
                  SizedBox(
                    width: 190.w,
                    child: AppTextForm(
                      onChanged: (String) {},
                      validator: (String) {
                        return null;
                      },
                      labelText: "Time",
                      hintText: "10:00 AM",
                    ),
                  ),
                ],
              ),
              AppSpacer.xtraHeightSpace,
              AppTextForm(
                onChanged: (String) {},
                validator: (String) {
                  return null;
                },
                labelText: AppText.aTCreateEventSeatFormText,
                hintText: AppText.aTCreateEventSeatFormSubText,
              ),
              AppSpacer.xtraHeightSpace,
              AppTextForm(
                onChanged: (String) {},
                validator: (String) {
                  return null;
                },
                labelText: AppText.aTCreateEventCategoryFormText,
                hintText: AppText.aTCreateEventCategoryFormSubText,
              ),
              AppSpacer.xtraHeightSpace,
              AppTextForm(
                onChanged: (String) {},
                validator: (String) {
                  return null;
                },
                labelText: AppText.aTCreateEventTypeFormText,
                hintText: AppText.aTCreateEventTypeFormSubText,
              ),
              AppSpacer.xtraHeightSpace,
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.location_on,
                  color: AppColors.exploreIconAsh,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColors.exploreIconAsh,
                  size: 14,
                ),
                title: Text(
                  AppText.aTCreateEventAddLocationText,
                  style: AppTextStyles.whiteMedium,
                ),
              ),
              AppSpacer.xtraHeightSpace,
             
              const AppButton(
                height: 50.0,
                //width: MediaQuery.of(context).size.width - 50,
                label: AppText.aTCreateEventCreateEventText,
                labelColor: Colors.white,
                buttonColor: AppColors.primary,
                // function: () => context
                //     .read<LocationAuthBloc>()
                //     .add(RequestLocationPermissionEvent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
