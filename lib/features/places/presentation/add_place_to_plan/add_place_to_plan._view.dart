import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/shared/constants/colors.dart';

class AddPlaceToPlan extends StatelessWidget {
  final PlaceModel place;
  const AddPlaceToPlan({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
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
      ]),
    );
  }
}
