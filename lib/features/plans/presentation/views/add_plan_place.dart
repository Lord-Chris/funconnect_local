import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/blocs/main_app_bloc.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/plans/presentation/blocs/plan_add_place_bloc/plan_add_place_bloc.dart';
import 'package:funconnect/shared/constants/colors.dart';

class AddPlanPlaceView extends StatefulWidget {
  const AddPlanPlaceView({super.key});

  @override
  State<AddPlanPlaceView> createState() => _AddPlanPlaceViewState();
}

class _AddPlanPlaceViewState extends State<AddPlanPlaceView> {
  final _placeFormInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add place",
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
            builder: (context, state) {
              if (state is HomeTrendsLoadedState) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff202020),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 8.w, top: 9.h, bottom: 9.h),
                    child: Form(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            size: 15,
                            color: Color(0xff999999),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _placeFormInputController,
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff999999),
                              ),
                              onTap: () async {
                                _placeFormInputController.text =
                                    await showSearch(
                                        context: context,
                                        delegate: MySearchDelegate(
                                            state.homeTrends.places[0].data));
                              },
                              textAlignVertical: TextAlignVertical.top,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xff202020),
                                hintText: "Find a place",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff999999),
                                ),
                                border: InputBorder.none,
                              ),
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
                );
              }
              return const SizedBox();
            },
          ),
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
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff202020),
        elevation: 0,
      ),
      textTheme: TextTheme(
          titleMedium: TextStyle(
        fontSize: 14.sp,
        color: const Color(0xff999999),
      )),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xff202020),
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
      icon: const Icon(
        Icons.arrow_back_ios_new,
        size: 15,
        color: Color(0xff999999),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(
      query,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff999999)),
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
          return Container(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          color: Colors.white,
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
                  context
                      .read<PlanAddPlaceBloc>()
                      .add(PlanAddPlaceEventClicked(suggestions[index].id));
                  close(context, suggestions[index].name);
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
