import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/places/presentation/blocs/search_result_bloc/search_result_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/search_result_bloc/search_result_event.dart';
import 'package:funconnect/features/places/presentation/blocs/search_result_bloc/search_result_state.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_large_widget.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class SearchResultView extends HookWidget {
  const SearchResultView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<SearchResultBloc>().add(const SearchBarChangedEvent(""));
      return null;
    }, []);
    final controller = useTextEditingController();
    return BlocBuilder<SearchResultBloc, SearchResultState>(
      builder: (context, state) {
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
                      child: TextField(
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 1,
                        style: AppTextStyles.regular14,
                        onChanged: (value) => context
                            .read<SearchResultBloc>()
                            .add(SearchBarChangedEvent(value)),
                        decoration: InputDecoration(
                          contentPadding: REdgeInsets.fromLTRB(16, 19, 16, 19),
                          hintText: "Search places",
                          filled: true,
                          fillColor: AppColors.exploreIconAsh,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                      ),
                    ),
                    Spacing.horizSmall(),
                    InkWell(
                      child: CircleAvatar(
                        radius: 27.r,
                        backgroundColor: AppColors.exploreIconAsh,
                        child: Icon(
                          Icons.filter_list_rounded,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    Spacing.horizRegular(),
                  ],
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is SearchResultLoadingState) {
                        return const Center(
                          child: AppLoader(
                            color: AppColors.primary,
                            size: 25,
                          ),
                        );
                      }
                      if (state is! SearchResultIdleState) {
                        return const SizedBox();
                      }
                      if (state.places.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.text.isEmpty
                                    ? "Query is empty"
                                    : "No place found for ${controller.text.capitalize()}",
                                style: AppTextStyles.medium14,
                              ),
                              Spacing.vertRegular(),
                              // AppButton(
                              //   label: "Retry",
                              //   isCollapsed: true,
                              //   labelColor: AppColors.black,
                              //   onTap: () => context
                              //       .read<CategoryDetailBloc>()
                              //       .add(CategoryInitEvent(category)),
                              // )
                            ],
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacing.vertExtraMedium(),
                            Padding(
                              padding: REdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Text(
                                    'Search results (${state.places.length})',
                                    style: AppTextStyles.regular14,
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Search history',
                                    style: AppTextStyles.regular14.copyWith(
                                      color: AppColors.gray97,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacing.vertRegular(),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.places.length,
                              padding: REdgeInsets.symmetric(horizontal: 16),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 182.r * 1.3,
                                childAspectRatio: 1,
                                mainAxisSpacing: 10.r,
                                crossAxisSpacing: 8.r,
                              ),
                              itemBuilder: (context, index) {
                                final place = state.places[index];
                                return HomeCategoriesLargeWidget(
                                  coverImage: place.coverImagePath,
                                  name: place.name,
                                  isBookmarked: place.isBookmarked,
                                  rating: place.avgRating,
                                  ratingCount: place.avgReviewCount,
                                  onTap: () => context
                                      .read<SearchResultBloc>()
                                      .add(PlaceTapEvent(place: place)),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}