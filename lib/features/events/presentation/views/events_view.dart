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
                onTap: () => context.read<DashboardBloc>().add(TabTapEvent(1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
