import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/plans/presentation/blocs/create_plan_bloc/create_plan_bloc.dart';

import 'package:funconnect/shared/constants/colors.dart';
import 'package:intl/intl.dart';

class CreatePlanView extends StatefulWidget {
  const CreatePlanView({super.key});

  @override
  State<CreatePlanView> createState() => _CreatePlanViewState();
}

class _CreatePlanViewState extends State<CreatePlanView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _planNameController = TextEditingController();

  @override
  void dispose() {
    _planNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a new plan"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Name",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                controller: _planNameController,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: const Color(0xff202020),
                  hintText: "What's the plan called...",
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff999999),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text("Description",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                controller: _planNameController,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: const Color(0xff202020),
                  hintText: "Describe the plan...",
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff999999),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 8.h,
                        ),
                        BlocBuilder<CreatePlanBloc, CreatePlanState>(
                          builder: (context, state) {
                            if (state is DateChangedState) {
                              return InkWell(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  ).then((value) {
                                    context.read<CreatePlanBloc>().add(
                                        DateSelectTapEvent(
                                            selectedDate: value));
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff202020),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      DateFormat("yMMMMd")
                                          .format(state.selectedDate),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                ).then((value) {
                                  context.read<CreatePlanBloc>().add(
                                      DateSelectTapEvent(selectedDate: value));
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xff202020),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    DateFormat("yMMMMd").format(context
                                        .watch<CreatePlanBloc>()
                                        .selectedDate),
                                    style: TextStyle(
                                        color: const Color(0xff999999),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 8.h,
                        ),
                        BlocBuilder<CreatePlanBloc, CreatePlanState>(
                            buildWhen: (previous, current) {
                          if (current is TimeChangedState) {
                            return true;
                          }
                          return false;
                        }, builder: (context, state) {
                          if (state is TimeChangedState) {
                            return InkWell(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  context.read<CreatePlanBloc>().add(
                                      TimeSelectTapEvent(selectedTime: value));
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xff202020),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    DateFormat("hh:mm a").format(DateTime(
                                      context
                                          .watch<CreatePlanBloc>()
                                          .selectedDate
                                          .year,
                                      context
                                          .watch<CreatePlanBloc>()
                                          .selectedDate
                                          .month,
                                      context
                                          .watch<CreatePlanBloc>()
                                          .selectedDate
                                          .day,
                                      state.selectedTime.hour,
                                      state.selectedTime.minute,
                                    )),
                                    style: TextStyle(
                                        color: const Color(0xff999999),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                context.read<CreatePlanBloc>().add(
                                    TimeSelectTapEvent(selectedTime: value));
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff202020),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  DateFormat("hh:mm a").format(
                                    DateTime(
                                        context
                                            .watch<CreatePlanBloc>()
                                            .selectedDate
                                            .year,
                                        context
                                            .watch<CreatePlanBloc>()
                                            .selectedDate
                                            .month,
                                        context
                                            .watch<CreatePlanBloc>()
                                            .selectedDate
                                            .day,
                                        context
                                            .watch<CreatePlanBloc>()
                                            .selectedDate
                                            .hour,
                                        context
                                            .watch<CreatePlanBloc>()
                                            .selectedDate
                                            .minute),
                                  ),
                                  style: TextStyle(
                                      color: const Color(0xff999999),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Text("Add place",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff202020),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xff999999),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Add a place",
                        style: TextStyle(
                            color: const Color(0xff999999),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () {
                          context
                              .read<CreatePlanBloc>()
                              .add(const SearchOnMapTapEvent());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.gray333,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: Text(
                              "Search Map",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
