import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/plans/presentation/blocs/plan_list/bloc/plan_list_bloc.dart';

import 'package:funconnect/features/plans/presentation/components/empty_plans_view.dart';

class PlansListView extends StatelessWidget {
  const PlansListView({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {});
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("My Plans",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<PlanListBloc>().add(CreatePlanClickedEvent());
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  size: 24,
                ),
              ),
            )
          ],
        ),
        body: BlocBuilder<PlanListBloc, PlanListState>(
          builder: (context, state) {
            if (state is PlanListEmptyState) {
              return const EmptyPLansView(
                isListEmpty: true,
              );
            }
            if (state is PlanListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PlanListFetchedState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          controller: scrollController,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                                height: 16.h,
                              ),
                          itemCount: state.data.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<PlanListBloc>()
                                    .add(OpenPlanEvent(state.data.data[index]));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff161616),
                                      borderRadius: BorderRadius.circular(8)),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(state.data.data[index].name,
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xffcccccc),
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                state.data.data[index]
                                                    .description,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff999999),
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.upload,
                                          color: Color(0xffcccccc),
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 96.h,
                    ),
                    const EmptyPLansView(
                      isListEmpty: false,
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text("Error"),
            );
          },
        ));
  }
}
