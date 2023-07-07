import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/dashboard/presentation/notifications/bloc/notification_bloc.dart';
import 'package:funconnect/shared/components/app_loader.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(NotificationInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: const BackButton(),
        title: Text(
          'Notifications',
          style: AppTextStyles.medium24,
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Container(),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoadingState &&
                state.notifications.isEmpty) {
              return const AppLoader();
            }
            if (state is NotificationFailureState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.failure.message,
                      style: AppTextStyles.medium14,
                    ),
                    Spacing.vertRegular(),
                    AppButton(
                      label: "Retry",
                      isCollapsed: true,
                      labelColor: AppColors.black,
                      onTap: () => context
                          .read<NotificationBloc>()
                          .add(NotificationInitEvent()),
                    )
                  ],
                ),
              );
            }
            if (state is! NotificationIdleState) return const SizedBox();
            if (state.notifications.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No notifications yet",
                        style: AppTextStyles.medium14,
                      ),
                      Spacing.vertRegular(),
                      AppButton(
                        label: "Refresh",
                        isCollapsed: true,
                        labelColor: AppColors.black,
                        onTap: () => context
                            .read<NotificationBloc>()
                            .add(NotificationRefreshEvent()),
                      )
                    ],
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                final bloc = context.read<NotificationBloc>();
                bloc.add(NotificationRefreshEvent());
                await bloc.stream.first;
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.notifications.length,
                separatorBuilder: (_, __) => Spacing.vertSmall(),
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.notificationWidgetBlack,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 7.sp,
                          color: notification.readAt != null
                              ? AppColors.green
                              : AppColors.red,
                        ),
                        Spacing.horizSmall(),
                        //const AppNetworkImage(
                        //url: AppConstants.mockImage,
                        //isCircular: true,
                        //fit: BoxFit.cover,
                        //size: Size.fromRadius(18),
                        //),
                        Spacing.horizRegular(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.data.title,
                                style: AppTextStyles.medium14,
                              ),
                              Text(
                                notification.data.message,
                                maxLines: 3,
                                style: AppTextStyles.regular12.copyWith(
                                  color: AppColors.gray97,
                                ),
                              ),
                              // Text.rich(
                              //   TextSpan(
                              //     children: [
                              //       TextSpan(
                              //         text: "System update! ",
                              //         style: AppTextStyles.regular12,
                              //       ),
                              //       TextSpan(
                              //         text:
                              //             "We've added new recreational centres to the best for you section.",
                              //         style: AppTextStyles.regular12.copyWith(
                              //           color: AppColors.gray97,
                              //         ),
                              //       ),
                              //       TextSpan(
                              //         text: " Check them out!",
                              //         style: AppTextStyles.medium12.copyWith(
                              //           color: AppColors.primary,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Spacing.vertExtraTiny(),
                              Text(
                                '${GeneralUtils.parseTime(notification.timeDifference)} ago',
                                style: AppTextStyles.dynamic(
                                  9,
                                  weight: FontWeight.w300,
                                  color: AppColors.gray97,
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacing.horizRegular(),
                        // AppButton(
                        //   label: "Book now",
                        //   isCollapsed: true,
                        //   labelColor: AppColors.black,
                        //   labelSize: 10.sm,
                        //   fontWeight: FontWeight.w500,
                        //   borderRadius: 6,
                        //   padding: REdgeInsets.fromLTRB(8, 4, 8, 4),
                        //   height: 24,
                        //   width: 54,
                        //   onTap: () {},
                        // ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
