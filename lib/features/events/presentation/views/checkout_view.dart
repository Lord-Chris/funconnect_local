import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/presentation/widgets/core_widgets.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        leading: const BackButton(color: AppColors.white),
        title: Text(
          "Checkout",
          style: AppTextStyles.medium24,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.2),
              border: Border.all(color: AppColors.primary, width: .5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error,
                  color: AppColors.primary,
                ),
                Spacing.horizSmall(),
                Expanded(
                  child: Text(
                    "Please accept Funconnect terms of service to complete this purchase.",
                    style: AppTextStyles.regular12.copyWith(
                      color: AppColors.gray1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "Contact information",
            style: AppTextStyles.medium20,
          ),
          Spacing.vertRegular(),
          Text(
            "* Required field",
            style: AppTextStyles.light14.copyWith(
              color: AppColors.gray97,
            ),
          ),
          Spacing.vertRegular(),
          AppTextField(
            label: "Full name *",
            textCapitalization: TextCapitalization.words,
            prefix: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: SvgPicture.asset(
                AppAssets.profileIconSvg,
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertRegular(),
          AppTextField(
            label: "E-mail *",
            keyboardType: TextInputType.emailAddress,
            prefix: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: SvgPicture.asset(
                AppAssets.emailIconSvg,
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertMedium(),
          _buildInfoTile(
              "Keep me updated on more events and news from this organizer"),
          Spacing.vertRegular(),
          _buildInfoTile(
              "Send me emails about the latest events happening nearby"),
          Spacing.vertExtraMedium(),
          Text(
            "1 Ticket: Free access to event",
            style: AppTextStyles.medium20,
          ),
          Spacing.vertExtraMedium(),
          AppDropdownField<String>(
            label: "Prefix",
            items: const ["Mr", "Miss", "Mrs"],
            value: "Mr",
            onChanged: (val) {},
            // validator: context.validateNotEmpty,
            prefix: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: SvgPicture.asset(
                AppAssets.profileIconSvg,
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertRegular(),
          AppTextField(
            label: "Full name *",
            textCapitalization: TextCapitalization.words,
            prefix: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: SvgPicture.asset(
                AppAssets.profileIconSvg,
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertRegular(),
          AppTextField(
            label: "Mobile Number",
            keyboardType: TextInputType.phone,
            prefix: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: SvgPicture.asset(
                AppAssets.profileIconSvg,
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertRegular(),
          AppTextField(
            label: "Job Title",
            textCapitalization: TextCapitalization.words,
            prefix: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: SvgPicture.asset(
                AppAssets.profileIconSvg,
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertRegular(),
          AppTextField(
            label: "Company",
            textCapitalization: TextCapitalization.words,
            prefix: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: SvgPicture.asset(
                AppAssets.profileIconSvg,
                color: AppColors.gray97,
              ),
            ),
          ),
          Spacing.vertExtraMedium(),
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.chatIconSvg,
                color: AppColors.gray97,
              ),
              Spacing.horizSmall(),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "By registering, you agree to our "),
                      TextSpan(
                        text: "Terms & Conditions",
                        style: AppTextStyles.regular14.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy policy",
                        style: AppTextStyles.regular14.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  style: AppTextStyles.light12.copyWith(
                    color: AppColors.gray1,
                  ),
                ),
              ),
            ],
          ),
          Spacing.vertRegular(),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  "NGN 0.00",
                  style: AppTextStyles.regular20.copyWith(
                    color: AppColors.gray97,
                  ),
                ),
                Spacing.horizRegular(),
                const Expanded(
                  child: AppButton(
                    label: "Register",
                    buttonColor: AppColors.primary,
                    labelColor: AppColors.black,
                    labelSize: 14,
                    // onTap: () => locator<INavigationService>()
                    //     .toNamed(Routes.bookingRoute),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String text) {
    return Row(
      children: [
        SvgPicture.asset(
          AppAssets.chatIconSvg,
          color: AppColors.gray97,
          width: 15,
        ),
        Spacing.horizSmall(),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.light12.copyWith(
              color: AppColors.gray1,
            ),
          ),
        ),
      ],
    );
  }
}
