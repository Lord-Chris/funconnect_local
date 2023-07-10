import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/presentation/category_detail/bloc/category_detail_bloc.dart';
import 'package:funconnect/features/places/presentation/category_detail/bloc/category_detail_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../domain/entities/category_model.dart';
import '../../domain/usecases/fetch_places.dart';
import '../home/widgets/categories_large_widget.dart';
import 'bloc/category_detail_event.dart';

class CategoryDetailView extends HookWidget {
  final CategoryModel category;
  const CategoryDetailView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<CategoryDetailBloc>().add(CategoryInitEvent(category.id));
      return null;
    }, []);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Spacing.horizRegular(),
                IconButton(
                  onPressed: () => locator<INavigationService>().back(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                    size: 14,
                  ),
                ),
                Spacing.horizSmall(),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context
                        .read<CategoryDetailBloc>()
                        .add(const SearchBarTapEvent()),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 1,
                      style: AppTextStyles.regular14,
                      decoration: InputDecoration(
                        contentPadding: REdgeInsets.fromLTRB(16, 19, 16, 19),
                        hintText: "Search places",
                        filled: true,
                        enabled: false,
                        fillColor: AppColors.exploreIconAsh,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacing.horizRegular(),
              ],
            ),
            Expanded(
              child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
                builder: (context, state) {
                  if (state is CategoryDetailLoadingState) {
                    return const Center(
                      child: AppLoader(
                        color: AppColors.primary,
                        size: 25,
                      ),
                    );
                  }
                  if (state is CategoryDetailFailureState) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.failure.message,
                            style: AppTextStyles.medium14,
                          ),
                          Spacing.vertRegular(),
                          AppButton(
                            label: "Retry",
                            isCollapsed: true,
                            labelColor: AppColors.black,
                            onTap: () => context
                                .read<CategoryDetailBloc>()
                                .add(CategoryInitEvent(category.id)),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is! CategoryDetailIdleState) {
                    return const SizedBox();
                  }
                  if (state.places.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No fun places in this category",
                            style: AppTextStyles.medium14,
                          ),
                          Spacing.vertRegular(),
                          AppButton(
                            label: "Retry",
                            isCollapsed: true,
                            labelColor: AppColors.black,
                            onTap: () => context
                                .read<CategoryDetailBloc>()
                                .add(CategoryInitEvent(category.id)),
                          )
                        ],
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacing.vertRegular(),
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          category.name,
                          style: AppTextStyles.medium28,
                        ),
                      ),
                      Spacing.vertTiny(),
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Explore the ${category.name.toLowerCase()}",
                          style: AppTextStyles.regular16,
                        ),
                      ),
                      Spacing.vertRegular(),
                      Expanded(
                        child: PaginatedPlaceGridView<PlaceModel>(
                          initialList: state.placeData,
                          moreFunction: (page) async =>
                              await FetchPlacesByCategory()
                                  .call(category.id, page + 1),
                          itemBuilder: (place) {
                            return HomeCategoriesLargeWidget(
                              showRatings: place.showRatings,
                              coverImage: place.coverImagePath,
                              name: place.name,
                              isBookmarked: place.isBookmarked,
                              rating: place.avgRating,
                              ratingCount: place.avgReviewCount,
                              onTap: () => context
                                  .read<CategoryDetailBloc>()
                                  .add(PlaceTapEvent(place: place)),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
