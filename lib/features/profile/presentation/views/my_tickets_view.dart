import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class MyTicketView extends StatelessWidget {
  const MyTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            'Tickets',
            style: AppTextStyles.medium24,
          ),
          actions: [
            IconButton(
              onPressed: null,
              icon: Container(),
            ),
          ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
            unselectedLabelColor: AppColors.white,
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(
                icon: Text('Upcoming(2)'),
              ),
              Tab(
                icon: Text('Past(1)'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: const [Text("")],
            ),
            ListView(
              children: const [Text("")],
            ),
          ],
        ),
      ),
    );
  }
}
