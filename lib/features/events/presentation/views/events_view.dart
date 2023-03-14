import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:funconnect/shared/components/custom_button.dart';

import '../../../../shared/constants/_constants.dart';
import '../../../dashboard/presentation/blocs/dashboard_bloc/dashboard_event.dart';

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  void initState() {
    super.initState();
    // context.read<EventsBloc>().add(EventInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.primary,
      //   onPressed: () =>
      //       locator<INavigationService>().toNamed(Routes.createEventRoute),
      //   child: const Center(
      //     child: Icon(Icons.add),
      //   ),
      // ),
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                AppAssets.eventIconSvg,
                height: 80.sp,
              ),
              Spacing.vertExtraMedium(),
              Text(
                "Events!",
                textAlign: TextAlign.center,
                style: AppTextStyles.regular24,
              ),
              Spacing.vertLarge(),
              Spacing.vertRegular(),
              Text(
                "Coming Soon!",
                textAlign: TextAlign.center,
                style: AppTextStyles.medium32,
              ),
              Spacing.vertRegular(),
              Flexible(
                child: Text(
                  "You will recieve a notification\nwhen we launch.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.gray97,
                  ),
                ),
              ),
              Spacing.vertLarge(),
              Center(
                child: AppButton(
                  label: 'Explore places',
                  labelColor: AppColors.black,
                  isCollapsed: true,
                  padding: REdgeInsets.fromLTRB(70, 20, 70, 20),
                  prefixWidget: Icon(
                    Icons.search,
                    color: AppColors.black,
                    size: 20.sp,
                  ),
                  onTap: () =>
                      context.read<DashboardBloc>().add(TabTapEvent(1)),
                ),
              ),
            ],
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         SizedBox(
          //           width: 323.w,
          //           child: const AppSearchField(
          //             labelText: 'Search places, people',
          //           ),
          //         ),
          //         CircleAvatar(
          //           radius: 25.0.r,
          //           backgroundColor: AppColors.exploreIconAsh,
          //           child: SvgPicture.asset('assets/icons/menu_icon.svg'),
          //         ),
          //       ],
          //     ),
          //     ListTile(
          //       contentPadding: EdgeInsets.zero,
          //       title: Padding(
          //         padding:
          //             EdgeInsets.only(left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
          //         child: Text(
          //           AppText.aTEvents,
          //           style: AppTextStyles.medium28,
          //         ),
          //       ),
          //       subtitle: Padding(
          //         padding: EdgeInsets.only(left: 8.0.w, bottom: 32.0.h),
          //         child: Text(
          //           AppText.aTEventBased,
          //           style: AppTextStyles.medium16.copyWith(
          //             color: AppColors.eventBasedColor,
          //           ),
          //         ),
          //       ),
          //       trailing: Padding(
          //         padding:
          //             EdgeInsets.only(left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
          //         child: const Icon(
          //           Icons.more_vert,
          //           color: AppColors.white,
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: BlocBuilder<EventsBloc, EventsState>(
          //         builder: (context, state) {
          //           if (state is EventsLoadingState) {
          //             return const Center(
          //               child: AppLoader(),
          //             );
          //           }
          //           if (state is EventsIdleState) {
          //             return ListView.builder(
          //               padding: EdgeInsets.zero,
          //               itemCount: state.events.length,
          //               itemBuilder: (context, index) {
          //                 return EventsPageEventWidget(
          //                   event: state.events[index],
          //                 );
          //               },
          //             );
          //           }
          //           return const SizedBox();
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
