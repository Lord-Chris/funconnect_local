import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_event.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_state.dart';
import 'package:funconnect/features/events/presentation/widgets/events_page_event_widget.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../../shared/constants/colors.dart';
import '../../../../../shared/constants/textstyles.dart';
import '../../../../shared/components/_components.dart';
import '../../../../shared/constants/app_text.dart';

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(EventInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () =>
            locator<INavigationService>().toNamed(Routes.createEventViewRoute),
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: AppColors.black,
      body: SafeArea(
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
                    child: const AppSearchField(
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
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding:
                      EdgeInsets.only(left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                  child: Text(
                    AppText.aTEvents,
                    style: AppTextStyles.medium28,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 8.0.w, bottom: 32.0.h),
                  child: Text(
                    AppText.aTEventBased,
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
              Expanded(
                child: BlocBuilder<EventsBloc, EventsState>(
                  builder: (context, state) {
                    if (state is EventsLoadingState) {
                      return const Center(
                        child: AppLoader(),
                      );
                    }
                    if (state is EventsIdleState) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.events.length,
                        itemBuilder: (context, index) {
                          return EventsPageEventWidget(
                            event: state.events[index],
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
