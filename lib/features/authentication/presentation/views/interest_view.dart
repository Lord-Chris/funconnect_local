import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_state.dart';

import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../shared/constants/textstyles.dart';
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
      body: BlocProvider<InterestsBloc>(
        create: (context) => InterestsBloc(),
        child: BlocBuilder<InterestsBloc, InterestsState>(
            builder: (context, state) {
          return AppBlackModalWidget(
            modalHeight: MediaQuery.of(context).size.height * 0.85,
            showBackButton: true,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        AppText.aTInterestText,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium24,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        AppText.aTInterestSelectText,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.light14,
                      ),
                      const SizedBox(height: 20),
                      if (state is InterestsInitialState)
                        Flexible(
                          child: GridView.builder(
                            itemCount: 20,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              final interest = state.interests[index];
                              return InterestSelectionWidget(
                                title: interest,
                                image: "",
                                isSelected:
                                    state.selectedInterest.contains(interest),
                                onSelected: (val) =>
                                    context.read<InterestsBloc>().add(
                                          InterestTapEvent(interest: interest),
                                        ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              AppOrangeBtn(
                label: AppText.aTAuthContinueText,
                onTap: () {},
              ),
            ],
          );
        }),
      ),
    );
  }
}
