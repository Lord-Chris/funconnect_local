import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';

import '../../../../shared/constants/_constants.dart';

class HomeInterestWidget extends StatelessWidget {
  final CategoryModel interest;
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
            CachedNetworkImage(
              imageUrl: interest.coverPhoto,
              placeholder: (context, url) =>
                  SvgPicture.asset(AppAssets.placesPlaceHolder),
              fit: BoxFit.cover,
            ),
            Spacing.horizSmall(),
            Text(
              interest.name,
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
