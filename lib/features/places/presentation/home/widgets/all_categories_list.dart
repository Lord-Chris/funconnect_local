import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import 'categories_container.dart';

class HomeAllCategoriesList extends StatelessWidget {
  final HomeV2LoadedState state;
  const HomeAllCategoriesList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 32.h,
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.categories.length,
      itemBuilder: (context, index1) {
        return SizedBox(
          height: 172.h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.categories[index1].name,
                      style: AppTextStyles.medium20,
                    ),
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
                  itemCount: state.categories[index1].data.length,
                  itemBuilder: (context, index) {
                    return HomeCategoryContainer(
                      category: state.categories[index1].data[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
