import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlansListView extends StatelessWidget {
  const PlansListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Create plan",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff0E0E0E),
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
                    "Create new plan",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff979797)),
                  )
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "You have no plans yet",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff979797)),
        ),
        Text(
          "Start your journey by creating a new plan",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff979797)),
        )
      ]),
    );
  }
}
