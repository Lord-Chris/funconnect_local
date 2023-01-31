import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/components/text_input.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../../shared/components/custom_button.dart';
import '../widgets/create_event_add_image_widget.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          onPressed: () => locator<INavigationService>().back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: 14,
          ),
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
              Spacing.vertRegular(),
              const Center(
                child: CreateEventAddImageWidget(),
              ),
              Spacing.vertRegular(),
              const AppTextField(
                label: AppText.aTCreateEventTextFormTitleText,
                hint: AppText.aTCreateEventTextFormSubTitleText,
                textCapitalization: TextCapitalization.words,
              ),
              Spacing.vertRegular(),
              const AppTextField(
                label: AppText.aTCreateEventDiscriptionFormText,
                hint: AppText.aTCreateEventDiscriptionFormSubText,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
              ),
              Spacing.vertRegular(),
              Row(
                children: [
                  SizedBox(
                    width: 190.w,
                    child: const AppTextField(
                      label: "Date",
                      hint: "DD/MM/YYYY",
                    ),
                  ),
                  Spacing.horizRegular(),
                  SizedBox(
                    width: 190.w,
                    child: const AppTextField(
                      label: "Time",
                      hint: "10:00 AM",
                    ),
                  ),
                ],
              ),
              Spacing.vertRegular(),
              const AppTextField(
                label: AppText.aTCreateEventSeatFormText,
                hint: AppText.aTCreateEventSeatFormSubText,
                keyboardType: TextInputType.number,
              ),
              Spacing.vertRegular(),
              AppDropdownField<String>(
                items: const [
                  "Concerts",
                  "Games",
                  "Picnics",
                  "Sip & Paints",
                  "Summit",
                  "Beach/Pool",
                  "Networking",
                  "Tour",
                  "Wine tasting",
                  "Fashion",
                  "Food",
                ],
                value: null,
                onChanged: (val) {},
                label: AppText.aTCreateEventCategoryFormText,
                hint: AppText.aTCreateEventCategoryFormSubText,
              ),
              Spacing.vertRegular(),
              AppDropdownField<String>(
                items: const [
                  "Public",
                  "Private",
                ],
                value: null,
                onChanged: (val) {},
                label: AppText.aTCreateEventTypeFormText,
                hint: AppText.aTCreateEventTypeFormSubText,
              ),
              Spacing.vertRegular(),
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
              Spacing.vertRegular(),
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
