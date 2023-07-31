import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/presentation/add_place_to_plan/bloc/add_place_to_plan_bloc.dart';
import 'package:funconnect/features/places/presentation/add_place_to_plan/components/plans_list_items.dart';
import 'package:funconnect/features/plans/presentation/components/empty_plans_view.dart';
import 'package:funconnect/shared/constants/colors.dart';

class AddPlaceToPlan extends StatelessWidget {
  final PlaceModel place;
  const AddPlaceToPlan({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    itemCount: state.plans.length,
                    itemBuilder: (context, index) {
                      return PlansListItem(
                        plan: state.plans[index],
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
              buildWhen: (previous, current) {
            return current is SelectionMadeState;
          }, builder: (context, state) {
            return context.watch<AddPlaceToPlanBloc>().selectedPlans.isEmpty
                ? const SizedBox()
                : Text(
                    "selected plans: ${context.watch<AddPlaceToPlanBloc>().selectedPlans.length} and state is ${state.toString()}");
          })
        ]),
      ),
    );
  }
}
