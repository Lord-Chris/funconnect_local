import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:intl/intl.dart';

class DateAndTimeDialog extends StatefulWidget {
  const DateAndTimeDialog({super.key});

  @override
  State<DateAndTimeDialog> createState() => _DateAndTimeDialogState();
}

class _DateAndTimeDialogState extends State<DateAndTimeDialog> {
  DateTime? selectedDate;
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
                          if (date != null) {
                            setState(() {
                              selectedDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  selectedDate?.hour ?? DateTime.now().hour,
                                  selectedDate?.minute ??
                                      DateTime.now().minute);
                            });
                          }
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
                                selectedDate == null
                                    ? "Date"
                                    : DateFormat("dd-MM-yyyy")
                                        .format(selectedDate!),
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

                        if (time != null) {
                          setState(() {
                            selectedDate = DateTime(
                                selectedDate?.year ?? DateTime.now().year,
                                selectedDate?.month ?? DateTime.now().month,
                                selectedDate?.day ?? DateTime.now().day,
                                time.hour,
                                time.minute);
                          });
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff202020),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              child: Text(
                                  selectedDate == null
                                      ? "Time"
                                      : DateFormat("hh:mm a")
                                          .format(selectedDate!),
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
                  onTap: () {
                    Navigator.pop(context, selectedDate);
                  },
                )
              ]),
        ),
      ),
    );
  }
}
