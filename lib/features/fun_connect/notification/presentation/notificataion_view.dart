import 'package:flutter/material.dart';
import 'package:funconnect/shared/dumb_widgets/dumb_app_strings.dart';

import '../../../../shared/constants/_constants.dart';
import '../widgets/notification_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          DumbAppStrings.notificationAppBarText,
          style: AppTextStyle.WhiteMedium,
        ),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            NotificationWidget(
              hasButton: false,
              read: false,
            ),
            NotificationWidget(
              hasButton: true,
              read: true,
            ),
          ],
        );
      }),
    );
  }
}
