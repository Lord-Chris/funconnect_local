import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/shared/components/app_network_image.dart';

import '../../../../shared/constants/_constants.dart';

class HomeInterestWidget extends StatelessWidget {
  final String interest;
  final bool isSelected;
  const HomeInterestWidget({
    Key? key,
    required this.interest,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.read<HomeBloc>().add(InterestTapEvent(interest: interest)),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: isSelected ? AppColors.primary : AppColors.interestWidgetAsh,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const AppNetworkImage(
              size: Size.fromRadius(10),
              url: AppConstants.mockImage,
              fit: BoxFit.cover,
              isCircular: true,
            ),
            Spacing.horizSmall(),
            Text(
              interest,
              maxLines: 1,
              style: AppTextStyles.regular12,
            ),
            Spacing.horizTiny(),
          ],
        ),
      ),
    );
  }
}
