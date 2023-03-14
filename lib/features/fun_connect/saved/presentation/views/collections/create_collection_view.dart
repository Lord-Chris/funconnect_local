import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../../../shared/components/app_textfield.dart';
import '../../../../../../shared/components/custom_button.dart';
import '../../widgets/create_collection_add_image_widget.dart';

class CreateCollectionView extends StatelessWidget {
  const CreateCollectionView({Key? key}) : super(key: key);

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
          AppText.aTCreateCollectionAppBarText,
          style: AppTextStyles.medium20,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing.vertRegular(),
              const Center(
                child: CreateCollectionAddImageWidget(),
              ),
              Spacing.vertRegular(),
              AppTextField(
                prefix: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 22.5, right: 8.0, bottom: 20.0),
                  child: SvgPicture.asset(
                    "assets/svgs/add-collection.svg",
                    width: 15,
                    height: 15,
                    fit: BoxFit.contain,
                  ),
                ),
                label: AppText.aTCreateCollectionTextFormTitleText,
                hint: AppText.aTCreateCollectionTextFormSubTitleText,
                textCapitalization: TextCapitalization.words,
              ),
              Spacing.vertLarge(),
              Text(
                "Categories",
                style: AppTextStyles.medium16.copyWith(color: AppColors.white),
              ),
              Spacing.vertRegular(),
              Text(
                "Add places from...",
                style:
                    AppTextStyles.regular14.copyWith(color: AppColors.gray333),
              ),
              Spacing.vertRegular(),
              
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: AppButton(
                  width: double.infinity,
                  height: 50.0,
                  label: AppText.aTCreateCollectionCreateCollectionText,
                  labelColor: AppColors.primary,
                  buttonColor: AppColors.primaryDark,
                  hasBorder: true,
                  borderColor: AppColors.createCollectionBorder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
