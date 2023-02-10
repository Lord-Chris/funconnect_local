import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/_constants.dart';

class HomeViewCategoriesWidget extends StatelessWidget {
  final String label;
  final Widget Function(int) child;
  final double? itemHeight;
  final bool showAll;
  // final int crossAxisCount;
  final void Function(bool)? onSeeAllTap;

  const HomeViewCategoriesWidget({
    Key? key,
    required this.label,
    required this.child,
    this.itemHeight,
    this.showAll = false,
    // this.crossAxisCount = 3,
    this.onSeeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.medium20,
              ),
              InkWell(
                onTap: () => onSeeAllTap?.call(!showAll),
                child: Text(
                  "See all",
                  style: AppTextStyles.medium14,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: showAll,
          replacement: SizedBox(
            height: itemHeight ?? 182.r,
            child: ListView.builder(
              padding: REdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.r),
                  child: child(index),
                );
              },
            ),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 20,
            padding: REdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: (itemHeight ?? 182.r) * 1.3,
              childAspectRatio: 1,
              mainAxisSpacing: 10.r,
              crossAxisSpacing: 8.r,
            ),
            itemBuilder: (context, index) {
              return child(index);
            },
          ),
        ),
      ],
    );
  }
}

class HomeSection<T> extends HookWidget {
  final String label;
  final List<T> children;
  final Widget Function(T) widget;
  final double? itemHeight;

  const HomeSection({
    Key? key,
    required this.label,
    required this.children,
    required this.widget,
    this.itemHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showAll = useState(false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.medium20,
              ),
              InkWell(
                onTap: () => showAll.value = !showAll.value,
                child: Text(
                  "See all",
                  style: AppTextStyles.medium14,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: showAll.value,
          replacement: SizedBox(
            height: itemHeight ?? 182.r,
            child: ListView.builder(
              padding: REdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: children.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.r),
                  child: widget(children[index]),
                );
              },
            ),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: children.length,
            padding: REdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: (itemHeight ?? 182.r) * 1.3,
              childAspectRatio: 1,
              mainAxisSpacing: 10.r,
              crossAxisSpacing: 8.r,
            ),
            itemBuilder: (context, index) {
              return widget(children[index]);
            },
          ),
        ),
      ],
    );
  }
}
