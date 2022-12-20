import 'package:flutter/material.dart';
import 'package:funconnect/core/presentation/widgets/app_auth_text_form_field.dart';
import 'package:funconnect/core/presentation/widgets/app_spacer.dart';
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
        title: Text(
          AppText.aTCreateEventAppBarText,
          style: AppTextStyle.whiteMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacer.xtraHeightSpace,
            const Center(
              child: CreateEventAddImageWidget(),
            ),
            AppSpacer.xtraHeightSpace,
            AppTextForm(
              onChanged: (String) {},
              validator: (String) {},
              labelText: AppText.aTCreateEventTextFormTitleText,
              hintText: AppText.aTCreateEventTextFormSubTitleText,
            ),
            AppTextForm(
              onChanged: (String) {},
              validator: (String) {},
              labelText: AppText.aTCreateEventDiscriptionFormText,
              hintText: AppText.aTCreateEventDiscriptionFormSubText,
              maxLines: 3,
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     children: [
            //       AppTextForm(
            //         onChanged: (String) {},
            //         validator: (String) {},
            //         labelText: "Date",
            //         hintText: "DD/MM/YYYY",
            //       ),
            //       AppTextForm(
            //         onChanged: (String) {},
            //         validator: (String) {},
            //         labelText: "Time",
            //         hintText: "10:00 AM",
            //       ),
            //     ],
            //   ),
            // ),
            AppTextForm(
              onChanged: (String) {},
              validator: (String) {},
              labelText: AppText.aTCreateEventSeatFormText,
              hintText: AppText.aTCreateEventSeatFormSubText,
            ),
            AppTextForm(
              onChanged: (String) {},
              validator: (String) {},
              labelText: AppText.aTCreateEventCategoryFormText,
              hintText: AppText.aTCreateEventCategoryFormSubText,
            ),
            AppTextForm(
              onChanged: (String) {},
              validator: (String) {},
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
              ),
              title: Text(
                AppText.aTCreateEventAddLocationText,
                style: AppTextStyle.whiteMedium,
              ),
            ),
            AppSpacer.xtraHeightSpace,
            const CustomButton(
              height: 50.0,
              //width: MediaQuery.of(context).size.width - 50,
              text: AppText.aTCreateEventCreateEventText,
              textColor: Colors.white,
              buttonColor: AppColors.primary,
              // function: () => context
              //     .read<LocationAuthBloc>()
              //     .add(RequestLocationPermissionEvent(),
            ),
          ],
        ),
      ),
    );
  }
}
