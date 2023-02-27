import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class MyEventsView extends StatelessWidget {
  const MyEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 11,
          ),
        ),
        title: Text(
          'My Events',
          style: AppTextStyles.medium24,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              size: 17,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            'Events you’ve created',
            style: AppTextStyles.medium16,
          ),
        ],
      )),
    );
  }
}
