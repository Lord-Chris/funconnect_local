import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notification",
          style: AppTextStyles.regular20,
        ),
      ),
    );
  }
}
