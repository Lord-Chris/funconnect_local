import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/presentation/widgets/app_auth_text_form_field.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/views/other_information_view.dart';
import 'package:funconnect/features/profile/presentation/views/personal_information_view.dart';
import 'package:funconnect/features/profile/presentation/views/social_network_information_view.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/components/scrollable_column.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/presentation/widgets/app_text.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      PersonalInformationView(),
      OtherInformationView(),
      SocialNetworkInformationView(),
    ];
    int currentPageIndex = 0;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              context
                  .read<EditProfileBloc>().add(BackTapEvent()),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 11,
          ),
        ),
        title: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return Row(
              children: [
                for (int i = 0; i < pages.length; i++)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 3.h,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          color: state.currentIndex >= i
                              ? AppColors.primary
                              : AppColors.lightAsh,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Container(),
          ),
        ],
      ),
      body: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return PageView(
            controller: state.pageController,
            onPageChanged: (int val)=> context
                .read<EditProfileBloc>().add(PageChangeEvent(val)),
            children: pages,
          );
        },
      ),
    );
  }
}
