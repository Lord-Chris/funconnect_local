import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:funconnect/shared/constants/colors.dart';

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
        title: const Text(
          "Create a  plan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Title",
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
                  hintText: "What's the title of the plan...",
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
              Text(
                "Add friends",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
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
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "E-mail address",
                        style: TextStyle(
                            color: const Color(0xff999999),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.gray333,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: Text(
                              "Add Email",
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
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 40,
                          decoration: const BoxDecoration(color: Colors.amber),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 16,
                          ),
                      itemCount: 2)),
            ]),
          ),
        ),
      ),
    );
  }
}
