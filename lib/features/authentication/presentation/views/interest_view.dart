import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../shared/constants/app_textStyle.dart';
import '../widgets/interest_selection_widget.dart';

class InterestView extends StatefulWidget {
  const InterestView({Key? key}) : super(key: key);

  @override
  State<InterestView> createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBlackModalWidget(
        modalHeight: MediaQuery.of(context).size.height,
        children: [
          SizedBox(
            height: 16.0,
          ),
          Text(AppText.aTInterestText,
              style: AppTextStyle.WhiteBold.copyWith(fontSize: 24.0)),
          const SizedBox(height: 8.0),
          Text(AppText.aTInterestSelectText,
              textAlign: TextAlign.center, style: AppTextStyle.WhiteMedium),
          const SizedBox(height: 29),
          Expanded(child:
              ListView.builder(itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                InterestSelectionWidget(),
                InterestSelectionWidget(),
              ],
            );
          })),
          const SizedBox(height: 62),
          App_Orange_Btn(
            label: AppText.aTAuthContinueText,
          ),
        ],
      ),
    );
  }
}
