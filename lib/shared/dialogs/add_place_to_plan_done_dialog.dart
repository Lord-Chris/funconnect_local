import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/constants/colors.dart';

class AddPlamToPlaceDoneDialog extends StatelessWidget {
  final FullPlaceModel selectedPlace;

  const AddPlamToPlaceDoneDialog({super.key, required this.selectedPlace});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.r),
            color: const Color(0xff161616),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(
                height: 32.h,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: '"${selectedPlace.name}" ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: 'has been succesfully added to  plan(s)',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ]),
              ),
              SizedBox(
                height: 32.h,
              ),
              AppButton(
                label: "View Plans",
                labelColor: Colors.white,
                onTap: () {
                  Navigator.pop(context, "view");
                },
                borderRadius: 8,
                buttonColor: const Color(0xff202020),
              ),
              SizedBox(
                height: 24.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, "description");
                },
                child: Text("Return to description page",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)),
              )
            ]),
          ),
        ));
  }
}
