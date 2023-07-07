import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class HomeAllInterestsContainer extends StatelessWidget {
  final List<CategoryModel> interests;
  const HomeAllInterestsContainer({
    super.key,
    required this.interests,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Spacing.horizTiny();
        },
        scrollDirection: Axis.horizontal,
        itemCount: interests.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.read<HomeV2Bloc>().add(HomeV2InterestClickedEvent(
                  interestClicked: interests[index]));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: AppColors.interestWidgetAsh,
              ),
              child: Row(
                children: [
                  FancyShimmerImage(
                    height: 20.r,
                    width: 20.r,
                    boxFit: BoxFit.cover,
                    shimmerBaseColor: AppColors.primary,
                    shimmerHighlightColor: AppColors.white,
                    boxDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    imageUrl: interests[index].coverPhoto,
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                          radius: 20.r, backgroundImage: imageProvider);
                    },
                    errorWidget: SvgPicture.asset(
                      AppAssets.profileIconSvg,
                      height: 25.r,
                      width: 25.r,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  Spacing.horizSmall(),
                  Text(
                    interests[index].name,
                    maxLines: 1,
                    style: AppTextStyles.regular12,
                  ),
                  Spacing.horizTiny(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
