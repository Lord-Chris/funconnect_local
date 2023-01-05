import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/fun_connect/event/presentation/widgets/events_page_event_widget.dart';

import '../../../../core/presentation/widgets/app_text.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/textstyles.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // AppTextForm(onChanged: (String) {}, validator: (_) {}),
                    CircleAvatar(
                      radius: 25.0.r,
                      backgroundColor: AppColors.exploreIconAsh,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.horizontal_split_sharp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                  child: Text(
                    AppText.aTEvents,
                    style: AppTextStyles.whiteMedium.copyWith(
                      fontSize: 28.0.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w, bottom: 32.0.h),
                  child: Text(
                    AppText.aTEventBased,
                    style:
                        AppTextStyles.whiteMedium.copyWith(fontSize: 16.0.sp),
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
