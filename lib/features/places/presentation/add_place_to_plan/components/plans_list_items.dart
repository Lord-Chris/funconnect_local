import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/presentation/add_place_to_plan/bloc/add_place_to_plan_bloc.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/shared/constants/colors.dart';

class PlansListItem extends StatefulWidget {
  final MiniPlanModel plan;
  const PlansListItem({super.key, required this.plan});

  @override
  State<PlansListItem> createState() => _PlansListItemState();
}

class _PlansListItemState extends State<PlansListItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected =
        context.watch<AddPlaceToPlanBloc>().selectedPlans.contains(widget.plan);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.c750, borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (isSelected) {
                  context
                      .read<AddPlaceToPlanBloc>()
                      .add(RemoveSelectionEvent(widget.plan));
                  isSelected = false;
                } else {
                  context
                      .read<AddPlaceToPlanBloc>()
                      .add(AddSelectionEvent(widget.plan));
                  isSelected = true;
                }
              });
            },
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(widget.plan.name),
          const SizedBox(),
        ]),
      ),
    );
  }
}
