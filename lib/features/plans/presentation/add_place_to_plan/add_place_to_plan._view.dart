import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/plans/presentation/add_place_to_plan/bloc/add_place_to_plan_bloc.dart';
import 'package:funconnect/features/plans/presentation/add_place_to_plan/components/plans_list_items.dart';

import 'package:funconnect/features/plans/presentation/components/empty_plans_view.dart';
import 'package:funconnect/features/plans/presentation/plan_list/bloc/plan_list_bloc.dart';
import 'package:funconnect/features/plans/presentation/plan_list/plans_list_view.dart';

import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/constants/colors.dart';

class AddPlaceToPlan extends StatelessWidget {
  final FullPlaceModel place;
  const AddPlaceToPlan({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: BlocListener<AddPlaceToPlanBloc, AddPlaceToPlanState>(
        listener: (context, state) async {
          if (state == AddPlaceToPlanSuccessState()) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider<PlanListBloc>(
                      create: (context) =>
                          PlanListBloc()..add(FetchMiniPlansEvent()),
                      child: const PlansListView()),
                ));
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Add ${place.name} to plan",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Click om the checkbox to add ${place.name} to your saved plans or create a new plan",
                style: TextStyle(
                    color: AppColors.gray97,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 24.h,
              ),
              BlocBuilder<AddPlaceToPlanBloc, AddPlaceToPlanState>(
                bloc: AddPlaceToPlanBloc()..add(LoadPlansListEvent()),
                builder: (context, state) {
                  if (state is AddPlaceToPlanLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is PlansListLoaded) {
                    return Expanded(
                      flex: 2,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 24.h,
                        ),
                        itemCount: state.plans.$1.length,
                        itemBuilder: (context, index) {
                          return PlansListItem(
                            plan: state.plans.$1[index],
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(
                height: 32.h,
              ),
              const Divider(
                thickness: 1,
                color: Color(0xff2c2c2c),
              ),
              SizedBox(
                height: 32.h,
              ),
              const EmptyPLansView(isListEmpty: false),
              const Expanded(flex: 1, child: SizedBox()),
              BlocBuilder<AddPlaceToPlanBloc, AddPlaceToPlanState>(
                  builder: (context, state) {
                return context.watch<AddPlaceToPlanBloc>().selectedPlans.isEmpty
                    ? const SizedBox()
                    : AppButton(
                        onTap: () {
                          context.read<AddPlaceToPlanBloc>().add(
                              AddPlaceToPlaButtonClickedEvent(
                                  place: place,
                                  selectedPlans: context
                                      .read<AddPlaceToPlanBloc>()
                                      .selectedPlans));
                        },
                        borderRadius: 8,
                        label:
                            "Add ${place.name} to plan (${context.watch<AddPlaceToPlanBloc>().selectedPlans.length})",
                      );
              }),
              SizedBox(
                height: 16.h,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
