import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';

import '../../data/repository/i_place_repository.dart';

class ReviewPlaceUseCase
    with UseCases<PaginatedData<ReviewModel>, ReviewParam> {
  final String placeId;
  ReviewPlaceUseCase(this.placeId);

  final _placeRepository = locator<IPlaceRepository>();

  @override
  Future<PaginatedData<ReviewModel>> call(ReviewParam params) async {
    await _placeRepository.reviewPlace(placeId, params);
    return await _placeRepository.fetchPlaceReviews(placeId);
  }
}
