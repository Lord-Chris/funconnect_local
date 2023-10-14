import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/blocs/main_app_bloc.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/plans/domain/entities/plan_add_place_arguments.dart';

import 'package:funconnect/features/plans/presentation/plan_add_place/bloc/plan_add_place_bloc.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class AddPlanPlaceView extends StatefulWidget {
  final PLanAddPLaceArguments arguments;

  const AddPlanPlaceView({
    super.key,
    required this.arguments,
  });

  @override
  State<AddPlanPlaceView> createState() => _AddPlanPlaceViewState();
}

class _AddPlanPlaceViewState extends State<AddPlanPlaceView> {
  final _placeFormInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _placeFormInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56.h,
        title: Text(
          widget.arguments.place == null ? "Add place" : "Edit place",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Add place",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<MainAppBloc, MainAppState>(
            builder: (context, state1) {
              if (state1 is HomeTrendsLoadedState) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xff202020)
                        : const Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 8.w, top: 9.h, bottom: 9.h),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            size: 15,
                            color: Color(0xff999999),
                          ),
                          Expanded(
                            child: BlocBuilder<PlanAddPlaceBloc,
                                PlanAddPlaceState>(
                              builder: (context, state) {
                                _placeFormInputController.text =
                                    state.place?.name ?? "";
                                return TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please select a place";
                                    }
                                    return null;
                                  },
                                  controller: _placeFormInputController,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff999999)
                                        : AppColors.secondary600,
                                  ),
                                  onTap: () async {
                                    PlaceModel place = await showSearch(
                                        context: context,
                                        delegate: MySearchDelegate(
                                            state1.homeTrends.places[0].data));
                                    if (mounted) {
                                      context
                                          .read<PlanAddPlaceBloc>()
                                          .add(PlanAddPlaceEventClicked(place));
                                    }
                                  },
                                  textAlignVertical: TextAlignVertical.top,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff202020)
                                        : const Color(0xfff1f1f1),
                                    hintText: "Find a place",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff999999),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                );
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<PlanAddPlaceBloc>()
                                  .add(const MapClickedEvent());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.gray333
                                    : AppColors.secondary200,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12),
                                child: Text(
                                  "Search Map",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
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
                );
              }
              return const SizedBox();
            },
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2024),
                        );
                        if (date != null) {
                          if (mounted) {
                            context
                                .read<PlanAddPlaceBloc>()
                                .add(DateSelectedEvent(date));
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xff202020)
                                    : const Color(0xfff1f1f1),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          child:
                              BlocBuilder<PlanAddPlaceBloc, PlanAddPlaceState>(
                            builder: (context, state) {
                              if (state.date != null) {
                                return Text(
                                  DateFormat("yMMMMd").format(state.date!),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff999999)
                                        : AppColors.secondary600,
                                  ),
                                );
                              }
                              return Text(
                                "Select Date",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0xff999999)
                                      : AppColors.secondary600,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: () async {
                      Logger().i("Date clicked");
                      var time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (mounted) {
                        context
                            .read<PlanAddPlaceBloc>()
                            .add(TimeSelectedEvent(time));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xff202020)
                              : const Color(0xfff1f1f1),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          child:
                              BlocBuilder<PlanAddPlaceBloc, PlanAddPlaceState>(
                            builder: (context, state) {
                              if (state.date != null) {
                                return Text(
                                  DateFormat("hh:mm a").format(state.date!),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff999999)
                                        : AppColors.secondary600,
                                  ),
                                );
                              }
                              return Text("Select Time",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff999999)
                                        : AppColors.secondary600,
                                  ));
                            },
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
          BlocBuilder<PlanAddPlaceBloc, PlanAddPlaceState>(
            buildWhen: (previous, current) {
              if (current is PlanAddPlaceLoading) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              Logger().i(state);
              if (state is PlanAddPlaceLoading) {
                const CircularProgressIndicator();
              }
              return AppButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.arguments.place == null) {
                      context
                          .read<PlanAddPlaceBloc>()
                          .add(AddPlaceEvent(widget.arguments.plan.id));
                    } else {
                      Logger().d(
                          "we are editing place with ${widget.arguments.placeIdentifierId} as id ");
                      context.read<PlanAddPlaceBloc>().add(
                          PlanEditPlaceSaveChangesEvent(
                              widget.arguments.plan.id,
                              widget.arguments.placeIdentifierId!));
                    }
                  }
                },
                label: widget.arguments.place == null
                    ? "Add Place"
                    : "Save Changes",
                borderRadius: 8,
              );
            },
          ),
          SizedBox(height: 16.h),
        ]),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final List<PlaceModel> places;

  MySearchDelegate(this.places);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
        fontSize: 14.sp,
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.secondary600
            : const Color(0xff999999),
      )),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.light
            ? const Color(0xfff1f1f1)
            : const Color(0xff202020),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xff999999),
        ),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      InkWell(
          onTap: () {
            if (query.isNotEmpty) {
              query = "";
            } else {
              close(context, null);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 14.sp, color: const Color(0xff999999)),
            ),
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 15,
        color: Theme.of(context).brightness == Brightness.light
            ? const Color(0xff999999)
            : const Color(0xff999999),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(
      query,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.red),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PlaceModel> suggestions = places
        .where((element) {
          return element.name.toLowerCase().contains(query.toLowerCase());
        })
        .map((e) => e)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 16.h,
        ),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.location_on_outlined),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestions[index].name,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    suggestions[index].headline,
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.secondary500,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                close(context, suggestions[index]);
              },
              child: Text(
                "Add",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
