import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyPLansPlacesView extends StatelessWidget {
  final VoidCallback onClick;
  const EmptyPLansPlacesView({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onClick,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff0E0E0E)
                    : const Color(0xfff1f1f1),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(
                    Icons.add,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Add a place",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onBackground),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),
      Text(
        "Add your favorite places to this plan and take control of your fun.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff979797)),
      ),
    ]);
  }
}
