import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';

import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/presentation/blocs/plan_details/bloc/plan_details_bloc.dart';
import 'package:funconnect/features/plans/presentation/blocs/plan_details/components/plan_place_item.dart';

import 'package:funconnect/features/plans/presentation/components/empty_plans_places_view.dart';
import 'package:funconnect/features/plans/presentation/components/friend_icon_empty_widget.dart';
import 'package:funconnect/features/plans/presentation/components/friend_icon_widget.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlanDetailsView extends StatelessWidget {
  final MiniPlanModel plan;
  const PlanDetailsView({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              plan.description,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff999999)),
            ),
            SizedBox(
              height: 24.h,
            ),
            Flexible(
              child: BlocBuilder(
                buildWhen: (previous, current) {
                  return current is PlanPlacesLoaded;
                },
                bloc: PlanDetailsBloc()..add(PlanPlacesLoad(plan)),
                builder: (context, state) {
                  if (state is PlanPlacesLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is PlanPlacesLoaded) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FutureBuilder<FullPlaceModel>(
                              future: PlanDetailsBloc()
                                  .getPlaceDetails(state.places[index].placeId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Skeletonizer(
                                      child:
                                          PlanPlaceItem(place: snapshot.data));
                                }
                                return (PlanPlaceItem(
                                  place: snapshot.data!,
                                ));
                              });
                        },
                        separatorBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child: const Divider(
                                color: Color(0xff2c2c2c),
                              ),
                            ),
                        itemCount: state.places.length);
                  }
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            EmptyPLansPlacesView(
              onClick: () {
                context
                    .read<PlanDetailsBloc>()
                    .add(AddAPlaceClickedEvent(plan));
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "Attendees",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 17.h,
            ),
            BlocBuilder(
              bloc: PlanDetailsBloc()..add(PlanFriendsLoad(plan)),
              builder: (context, state) {
                if (state is PlanFriendsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is PlanFriendsLoaded) {
                  return SizedBox(
                      height: 65.h,
                      width: double.infinity,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == state.friends.data.length) {
                              return const FriendIconEmptyWidget();
                            } else {
                              return FriendIconWidget(
                                email: state.friends.data[index].email,
                              );
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                width: 8.w,
                              ),
                          itemCount: state.friends.data.length + 1));
                }
                return const SizedBox();
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            const AppButton(
              label: "Save Plan",
              borderRadius: 8,
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
