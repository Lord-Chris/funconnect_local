import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/features/places/presentation/widgets/home_places_comtainer.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class HomeAllPlacesList extends StatelessWidget {
  final HomeV2LoadedState state;
  const HomeAllPlacesList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 32.h,
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.places.length,
      itemBuilder: (context, index1) {
        return SizedBox(
          height: 223.h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.places[index1].name,
                        style: AppTextStyles.medium20),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 8.w,
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.places[index1].data.length,
                    itemBuilder: (context, index) {
                      return HomePlaceContainer(
                          place: state.places[index1].data[index]);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
