import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:funconnect/features/plans/presentation/plan_list/bloc/plan_list_bloc.dart';

class EmptyPLansView extends StatelessWidget {
  final bool isListEmpty;
  const EmptyPLansView({
    super.key,
    required this.isListEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              context.read<PlanListBloc>().add(CreatePlanClickedEvent());
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff0E0E0E),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(
                    Icons.add,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Create new plan",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff979797)),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),
      Text(
        isListEmpty
            ? "You have no plans yet"
            : "Continue your journey by creating",
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff979797)),
      ),
      Text(
        isListEmpty
            ? "Start your journey by creating a new plan"
            : "a new plan",
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff979797)),
      )
    ]);
  }
}
