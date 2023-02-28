import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/constants/app_spacer.dart';
import 'package:funconnect/shared/constants/colors.dart';

import '../../../../../shared/components/app_loader.dart';
import '../../../../../shared/constants/app_text.dart';
import '../../../../../shared/constants/textstyles.dart';
import '../../../../events/presentation/blocs/events_bloc/events_bloc.dart';
import '../../../../events/presentation/blocs/events_bloc/events_state.dart';
import '../../../../events/presentation/widgets/events_page_event_widget.dart';

class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    //context.read<EventsBloc>().add(EventInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding:
                      EdgeInsets.only(left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                  child: Text(
                    AppText.aTSaved,
                    style: AppTextStyles.medium28,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 8.0.w, bottom: 32.0.h),
                  child: Text(
                    AppText.aTSavedSubtext,
                    style: AppTextStyles.medium16.copyWith(
                      color: AppColors.eventBasedColor,
                    ),
                  ),
                ),
                trailing: Padding(
                  padding:
                      EdgeInsets.only(left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                  child: const Icon(
                    Icons.more_vert,
                    color: AppColors.white,
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: AppColors.primary,
                indicatorWeight: 4,
                labelColor: AppColors.primary,
                labelStyle:
                    AppTextStyles.medium16.copyWith(color: AppColors.primary),
                unselectedLabelColor: Colors.white,
                unselectedLabelStyle:
                    AppTextStyles.medium16.copyWith(color: Colors.white),
                tabs: const [
                  Tab(
                    text: 'Recreation(0)',
                  ),
                  Tab(
                    text: 'Events(0)',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 24.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No saved items yet",
                              style: AppTextStyles.regular16
                                  .copyWith(color: AppColors.white),
                            ),
                            Spacing.vertExtraLarge(),
                            Container(
                              height: 30.0.h,
                              width: 60.0.w,
                              decoration: BoxDecoration(
                                color: AppColors.imgContainerBlack,
                                borderRadius: BorderRadius.circular(20.0.r),
                              ),
                              child: Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    border: Border.all(
                                        width: 3.0.w,
                                        color: AppColors.exploreIconAsh),
                                  ),
                                  child: Text(
                                    "Add collection",
                                    style: AppTextStyles.medium20.copyWith(
                                      color: AppColors.locationIconAsh,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 24.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No saved items yet",
                              style: AppTextStyles.regular16
                                  .copyWith(color: AppColors.white),
                            ),
                            Spacing.vertExtraLarge(),
                            Container(
                              height: 30.0.h,
                              width: 60.0.w,
                              decoration: BoxDecoration(
                                color: AppColors.imgContainerBlack,
                                borderRadius: BorderRadius.circular(20.0.r),
                              ),
                              child: Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    border: Border.all(
                                        width: 3.0.w,
                                        color: AppColors.exploreIconAsh),
                                  ),
                                  child: Text(
                                    "Add collection",
                                    style: AppTextStyles.medium20.copyWith(
                                      color: AppColors.locationIconAsh,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
