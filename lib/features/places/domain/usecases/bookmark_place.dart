import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';

class BookmarkPlace with UseCases<FullPlaceModel, FullPlaceModel> {
  final _repo = locator<IPlaceRepository>();

  @override
  Future<FullPlaceModel> call(FullPlaceModel params) async {
    bool isBookMarked = params.isBookmarked;
    isBookMarked = await _repo.toggleBookmark(params, !isBookMarked);
    return params.copyWith();
  }
}
