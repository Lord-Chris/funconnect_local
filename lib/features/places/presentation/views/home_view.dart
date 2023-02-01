import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/components/_components.dart';
import '../widgets/home_categories_large_widget.dart';
import '../widgets/home_categories_small_widget.dart';
import '../widgets/home_categories_widget.dart';
import '../widgets/home_interest_widget.dart';

class HomeView extends StatefulHookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    final showAllCategory = useState(false);
    final showAllBest = useState(false);
    final showAllRecents = useState(false);
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Spacing.horizSmall(),
                    AppNetworkImage(
                      borderRadius: 50.r,
                      isCircular: true,
                      url: AppConstants.mockImage,
                      fit: BoxFit.cover,
                    ),
                    Spacing.horizRegular(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi John",
                          style: AppTextStyles.medium20,
                        ),
                        Spacing.vertTiny(),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.locationIconAsh,
                              size: 13,
                            ),
                            Text(
                              "Yaba, Lagos",
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.secondary400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bell_fill,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Spacing.vertSmall(),
            const Divider(
              color: AppColors.secondary500,
              height: 1,
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const AppLoader(
                      color: AppColors.primary,
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: SizedBox(
                            height: 35.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 5.r),
                                  child: const HomeInterestWidget(),
                                );
                              },
                            ),
                          ),
                        ),
                        const Divider(
                          color: AppColors.secondary500,
                          height: 1,
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacing.vertRegular(),
                            Padding(
                              padding: REdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Fine Dining",
                                style: AppTextStyles.medium28,
                              ),
                            ),
                            Spacing.vertTiny(),
                            Padding(
                              padding: REdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Explore the best cuisines",
                                style: AppTextStyles.regular16,
                              ),
                            ),
                            Spacing.vertRegular(),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
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
                                return const HomeCategoriesLargeWidget();
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HomeViewCategoriesWidget(
                              label: "Categories",
                              itemHeight: 136.r,
                              showAll: showAllCategory.value,
                              onSeeAllTap: (val) => showAllCategory.value = val,
                              child: const HomeViewCategoriesSmallSubWidget(),
                            ),
                            Spacing.vertSmall(),
                            HomeViewCategoriesWidget(
                              label: "Best for you",
                              showAll: showAllBest.value,
                              onSeeAllTap: (val) => showAllBest.value = val,
                              child: const HomeCategoriesLargeWidget(),
                            ),
                            Spacing.vertSmall(),
                            HomeViewCategoriesWidget(
                              label: "Recently added",
                              showAll: showAllRecents.value,
                              onSeeAllTap: (val) => showAllRecents.value = val,
                              child: const HomeCategoriesLargeWidget(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
