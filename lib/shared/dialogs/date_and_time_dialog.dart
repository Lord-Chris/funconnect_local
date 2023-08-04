import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/custom_button.dart';

class DateAndTimeDialog extends StatelessWidget {
  const DateAndTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xff161616),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 16.w, top: 21.h, right: 16.w, bottom: 40.h),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Set time & date",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2024),
                          );
                          if (date != null) {}
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xff202020),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              child: Text(
                                "Date",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () async {
                        var time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff202020),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              child: Text("Time",
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white)))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                AppButton(
                  borderRadius: 8.r,
                  label: "Continue",
                  onTap: () {},
                )
              ]),
        ),
      ),
    );
  }
}
