import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/fun_connect/event/presentation/widgets/events_page_event_widget.dart';
import 'package:funconnect/shared/components/text_input.dart';

import '../../../../../core/presentation/widgets/app_text.dart';
import '../../../../../shared/constants/colors.dart';
import '../../../../../shared/constants/textstyles.dart';
import 'create_event_view.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateEventView(),
              ));
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 323.w,
                      child: AppSearchField(
                        labelText: 'Search places, people',
                      ),
                    ),
                    CircleAvatar(
                      radius: 25.0.r,
                      backgroundColor: AppColors.exploreIconAsh,
                      child: SvgPicture.asset('assets/icons/menu_icon.svg'),
                    ),
                  ],
                ),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(
                        left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                    child: Text(
                      AppText.aTEvents,
                      style: AppTextStyles.whiteMedium.copyWith(
                        fontSize: 28.0.sp,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(left: 8.0.w, bottom: 32.0.h),
                    child: Text(
                      AppText.aTEventBased,
                      style: AppTextStyles.whiteMedium.copyWith(
                          fontSize: 16.0.sp, color: AppColors.eventBasedColor),
                    ),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(
                        left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                    child: const Icon(
                      Icons.more_vert,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 256,
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        EventsPageEventWidget(
                          isPublic: false,
                        ),
                        EventsPageEventWidget(
                          isPublic: true,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
