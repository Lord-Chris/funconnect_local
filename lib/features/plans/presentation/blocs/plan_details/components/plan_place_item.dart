import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/app_assets.dart';

class PlanPlaceItem extends StatelessWidget {
  final FullPlaceModel? place;
  const PlanPlaceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNetworkImage(
          url: place?.coverImagePath ?? "",
          size: Size(60.w, 60.h),
          borderRadius: 8,
          fit: BoxFit.cover,
          placeholderAssetImage: AppAssets.add,
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place?.name ?? "",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffcccccc)),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                place?.location?.address ?? "",
                style: TextStyle(
                    color: const Color(0xff999999),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                  "${place?.opensAtParsed.format(context)} - ${place?.closesAtParsed.format(context)}",
                  style: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 16.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 30.r,
                    color: const Color(0xff999999),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "03:30 PM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      const Text(
                        "Saturday, 12 June, 2023",
                        style: TextStyle(
                            color: Color(0xff999999),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
