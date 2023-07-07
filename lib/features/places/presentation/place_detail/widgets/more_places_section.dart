import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/place_model.dart';
import '../../home/widgets/categories_large_widget.dart';
import '../../home/widgets/categories_widget.dart';
import '../bloc/place_detail_bloc.dart';
import '../bloc/place_detail_event.dart';
import '../bloc/place_detail_state.dart';

class MorePlacesSection extends StatelessWidget {
  const MorePlacesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailBloc, PlaceDetailState>(
      buildWhen: (_, current) => current is PlaceDetailIdleState,
      builder: (context, state) {
        if (state is! PlaceDetailIdleState) return const SizedBox();
        if (state.place.similarPlaces.isEmpty) return const SizedBox();
        return HomeSection<PlaceModel>(
          label: "More like this",
          children: state.place.similarPlaces.map((e) => e).toList(),
          widget: (PlaceModel place) {
            return HomeCategoriesLargeWidget(
              showRatings: place.showRatings,
              coverImage: place.coverImagePath,
              name: place.name,
              isBookmarked: place.isBookmarked,
              rating: place.avgRating,
              ratingCount: place.avgReviewCount,
              onTap: () => context.read<PlaceDetailBloc>().add(
                    PlaceTapEvent(place: place),
                  ),
            );
          },
        );
      },
    );
  }
}
